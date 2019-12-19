---
title: WebRTC 开发（九）音频采集与渲染
date: 2019-12-17 19:10:01
tags:
- 音视频处理
- WebRTC
categories:
- WebRTC
---

本文基于 [WebRTC M76](https://groups.google.com/forum/#!msg/discuss-webrtc/Y7TIuNbgP8M/UoXP-RuxAwAJ) 来分析下 Mac 端的音频采集和渲染逻辑。

> ### 代码位置

代码位置：[webrtc/src/modules/audio_device/mac](https://chromium.googlesource.com/external/webrtc/+/9863f3d246e2da7a2e1f42bbc5757f6af5ec5682/modules/audio_device/mac/)

```
audio_device_mac.h                    
audio_device_mac.cc

audio_mixer_manager_mac.h         
audio_mixer_manager_mac.cc
```

<!-- more -->

> ### 浏览头文件

预览 [webrtc/src/modules/audio_device/mac/audio_device_mac.h](https://chromium.googlesource.com/external/webrtc/+/9863f3d246e2da7a2e1f42bbc5757f6af5ec5682/modules/audio_device/mac/audio_device_mac.h)，可以看到音频采集和渲染的很多信息。

```
采集的采样率：const uint32_t N_REC_SAMPLES_PER_SEC = 48000;
播放的采样率：const uint32_t N_PLAY_SAMPLES_PER_SEC = 48000;
```

```
采集的声道数目： const uint32_t N_REC_CHANNELS = 1;   // default is mono recording
播放的声道数目：const uint32_t N_PLAY_CHANNELS = 2;  // default is stereo playout
```

```
音频的 buffer size：const int kBufferSizeMs = 10; 用的是 10ms
```

这里顺带讲解下音频采样率和时间的关系：假设音频采集的采样率为 48000，就是在 1 秒的时长内，采集了 48000 个点的数据，即，1000ms 可以获取 48000 个采样点，换言之 10 ms 可以获取 480 个采样点。每个采样点占用几个字节，这就需要结合实际情形来计算。

举个例子，假设以 `AudioStreamBasicDescription audioDescription` 结构来描述音频信息：

```
audioDescription.mSampleRate = 48000;
audioDescription.mFormatID = kAudioFormatLinearPCM;
audioDescription.mFormatFlags = kAudioFormatFlagIsSignedInteger;
audioDescription.mFramesPerPacket = 1;
audioDescription.mBitsPerChannel = 16;
audioDescription.mChannelsPerFrame = 1;
audioDescription.mBytesPerFrame = audioDescription.mChannelsPerFrame * (audioDescription.mBitsPerChannel / 8);
audioDescription.mBytesPerPacket = audioDescription.mFramesPerPacket * audioDescription.mBytesPerFrame;
```

可以计算出 audioDescription.mBytesPerFrame = 2，audioDescription.mBytesPerPacket = 2，也就是每个音频帧占用2个字节。1000ms 可以获取 48000 个采样点，那就是 48000 * 2 字节。10ms 可以获取 480 个采样点，那就是 480 * 2 = 960 字节。

> ### 浏览代码实现

WebRTC 的代码因为是跨平台的，为了兼容各个平台，API 接口写的有些繁琐。如果想快速看出代码的执行逻辑，最快最实用的就是加断点，单步调试。如果对各个系统（iOS，Mac，Android）的系统音视频 API 比较熟悉的话，那是可以直接通过读代码来梳理逻辑的。

下面列举下音视频采集和渲染中很关键的点：**音频采集回调**，**音频渲染回调**，**音频路由切换监听事件**。

预览 [webrtc/src/modules/audio_device/mac/audio_device_mac.cc](https://chromium.googlesource.com/external/webrtc/+/9863f3d246e2da7a2e1f42bbc5757f6af5ec5682/modules/audio_device/mac/audio_device_mac.cc)

音频采集的回调：

```
int32_t AudioDeviceMac::InitRecording() {
  RTC_LOG(LS_INFO) << "InitRecording";
  
  ......

  if (_twoDevices) {
    WEBRTC_CA_RETURN_ON_ERR(AudioDeviceCreateIOProcID(
        _inputDeviceID, inDeviceIOProc, this, &_inDeviceIOProcID));
  } else if (!_playIsInitialized) {
    WEBRTC_CA_RETURN_ON_ERR(AudioDeviceCreateIOProcID(
        _inputDeviceID, deviceIOProc, this, &_deviceIOProcID));
  }
  
  ......

} 
```

```
OSStatus AudioDeviceMac::inDeviceIOProc(AudioDeviceID,
                                        const AudioTimeStamp*,
                                        const AudioBufferList* inputData,
                                        const AudioTimeStamp* inputTime,
                                        AudioBufferList*,
                                        const AudioTimeStamp*,
                                        void* clientData) {
  AudioDeviceMac* ptrThis = (AudioDeviceMac*)clientData;
  RTC_DCHECK(ptrThis != NULL);

  ptrThis->implInDeviceIOProc(inputData, inputTime);

  // AudioDeviceIOProc functions are supposed to return 0
  return 0;
}
```

音频渲染的回调：

```
int32_t AudioDeviceMac::InitPlayout() {
  RTC_LOG(LS_INFO) << "InitPlayout";

  ......

   if (_twoDevices || !_recIsInitialized) {
    WEBRTC_CA_RETURN_ON_ERR(AudioDeviceCreateIOProcID(
        _outputDeviceID, deviceIOProc, this, &_deviceIOProcID));
  }
          
  ......

}
```

```
OSStatus AudioDeviceMac::deviceIOProc(AudioDeviceID,
                                      const AudioTimeStamp*,
                                      const AudioBufferList* inputData,
                                      const AudioTimeStamp* inputTime,
                                      AudioBufferList* outputData,
                                      const AudioTimeStamp* outputTime,
                                      void* clientData) {
  AudioDeviceMac* ptrThis = (AudioDeviceMac*)clientData;
  RTC_DCHECK(ptrThis != NULL);

  ptrThis->implDeviceIOProc(inputData, inputTime, outputData, outputTime);

  // AudioDeviceIOProc functions are supposed to return 0
  return 0;
}
```

音频路由切换监听事件：

```
OSStatus AudioDeviceMac::objectListenerProc(
    AudioObjectID objectId,
    UInt32 numberAddresses,
    const AudioObjectPropertyAddress addresses[],
    void* clientData) {
  AudioDeviceMac* ptrThis = (AudioDeviceMac*)clientData;
  RTC_DCHECK(ptrThis != NULL);

  ptrThis->implObjectListenerProc(objectId, numberAddresses, addresses);

  // AudioObjectPropertyListenerProc functions are supposed to return 0
  return 0;
}
```

```
OSStatus AudioDeviceMac::implObjectListenerProc(
    const AudioObjectID objectId,
    const UInt32 numberAddresses,
    const AudioObjectPropertyAddress addresses[]) {
  RTC_LOG(LS_VERBOSE) << "AudioDeviceMac::implObjectListenerProc()";

  for (UInt32 i = 0; i < numberAddresses; i++) {
    if (addresses[i].mSelector == kAudioHardwarePropertyDevices) {
      HandleDeviceChange();
    } else if (addresses[i].mSelector == kAudioDevicePropertyStreamFormat) {
      HandleStreamFormatChange(objectId, addresses[i]);
    } else if (addresses[i].mSelector == kAudioDevicePropertyDataSource) {
      HandleDataSourceChange(objectId, addresses[i]);
    } else if (addresses[i].mSelector == kAudioDeviceProcessorOverload) {
      HandleProcessorOverload(addresses[i]);
    }
  }

  return 0;
}
```




