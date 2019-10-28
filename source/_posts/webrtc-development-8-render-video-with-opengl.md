---
title: WebRTC 开发（八）使用 OpenGL 渲染视频
date: 2019-10-28 18:13:43
tags:
- 音视频处理
- WebRTC
categories:
- WebRTC
---

前文 [WebRTC 开发（六）摄像头采集与视频渲染分析](https://depthlove.github.io/2019/10/22/webrtc-development-6-video-rendering-analysis/) 提到了 WebRTC 视频渲染的大概流程，但没有具体分析每个实现文件的功能，本文会深入到具体的实现文件。

> ### 渲染的代码位置

代码位置：webrtc/src/sdk/objc/components/renderer

```
# opengl

RTCNSGLVideoView.h          RTCNSGLVideoView.m
RTCEAGLVideoView.h          RTCEAGLVideoView.m
RTCOpenGLDefines.h          RTCVideoViewShading.h
RTCDefaultShader.h          RTCDefaultShader.mm
RTCShader.h                 RTCShader.mm
RTCNV12TextureCache.h       RTCNV12TextureCache.m
RTCI420TextureCache.h       RTCI420TextureCache.mm
RTCDisplayLinkTimer.h       RTCDisplayLinkTimer.m
```

<!-- more -->

> ### 渲染的核心代码块

> #### 初始化

> ##### RTCNSGLVideoView.m

```
- (instancetype)initWithFrame:(NSRect)frame pixelFormat:(NSOpenGLPixelFormat *)format {
  return [self initWithFrame:frame pixelFormat:format shader:[[RTCDefaultShader alloc] init]];
}

- (instancetype)initWithFrame:(NSRect)frame
                  pixelFormat:(NSOpenGLPixelFormat *)format
                       shader:(id<RTCVideoViewShading>)shader {
  if (self = [super initWithFrame:frame pixelFormat:format]) {
    _shader = shader;
  }
  return self;
}

```

> #### 图像绘制

目前，WebRTC 在 Mac 端只支持 I420 的绘制，不支持 NV12 的绘制。具体见 **RTCDefaultShader.m** 中 **- (void)drawFrame** 方法中的注释： 

```
// Rendering native CVPixelBuffer is not supported on OS X.
// TODO(magjed): Add support for NV12 texture cache on OS X.
```

> ##### RTCNSGLVideoView.m

```
- (void)drawFrame {
  RTCVideoFrame *frame = self.videoFrame;
  if (!frame || frame == _lastDrawnFrame) {
    return;
  }
  // This method may be called from CVDisplayLink callback which isn't on the
  // main thread so we have to lock the GL context before drawing.
  NSOpenGLContext *context = [self openGLContext];
  CGLLockContext([context CGLContextObj]);

  [self ensureGLContext];
  glClear(GL_COLOR_BUFFER_BIT);

  // Rendering native CVPixelBuffer is not supported on OS X.
  // TODO(magjed): Add support for NV12 texture cache on OS X.
  frame = [frame newI420VideoFrame];
  if (!self.i420TextureCache) {
    self.i420TextureCache = [[RTCI420TextureCache alloc] initWithContext:context];
  }
  RTCI420TextureCache *i420TextureCache = self.i420TextureCache;
  if (i420TextureCache) {
    [i420TextureCache uploadFrameToTextures:frame];
    [_shader applyShadingForFrameWithWidth:frame.width
                                    height:frame.height
                                  rotation:frame.rotation
                                    yPlane:i420TextureCache.yTexture
                                    uPlane:i420TextureCache.uTexture
                                    vPlane:i420TextureCache.vTexture];
    [context flushBuffer];
    _lastDrawnFrame = frame;
  }
  CGLUnlockContext([context CGLContextObj]);
}
```

> ##### RTCI420TextureCache.mm

```
- (void)uploadPlane:(const uint8_t *)plane
            texture:(GLuint)texture
              width:(size_t)width
             height:(size_t)height
             stride:(int32_t)stride {
  glBindTexture(GL_TEXTURE_2D, texture);

  const uint8_t *uploadPlane = plane;
  if ((size_t)stride != width) {
   if (_hasUnpackRowLength) {
      // GLES3 allows us to specify stride.
      glPixelStorei(GL_UNPACK_ROW_LENGTH, stride);
      glTexImage2D(GL_TEXTURE_2D,
                   0,
                   RTC_PIXEL_FORMAT,
                   static_cast<GLsizei>(width),
                   static_cast<GLsizei>(height),
                   0,
                   RTC_PIXEL_FORMAT,
                   GL_UNSIGNED_BYTE,
                   uploadPlane);
      glPixelStorei(GL_UNPACK_ROW_LENGTH, 0);
      return;
    } else {
      // Make an unpadded copy and upload that instead. Quick profiling showed
      // that this is faster than uploading row by row using glTexSubImage2D.
      uint8_t *unpaddedPlane = _planeBuffer.data();
      for (size_t y = 0; y < height; ++y) {
        memcpy(unpaddedPlane + y * width, plane + y * stride, width);
      }
      uploadPlane = unpaddedPlane;
    }
  }
  glTexImage2D(GL_TEXTURE_2D,
               0,
               RTC_PIXEL_FORMAT,
               static_cast<GLsizei>(width),
               static_cast<GLsizei>(height),
               0,
               RTC_PIXEL_FORMAT,
               GL_UNSIGNED_BYTE,
               uploadPlane);
}

- (void)uploadFrameToTextures:(RTCVideoFrame *)frame {
  _currentTextureSet = (_currentTextureSet + 1) % kNumTextureSets;

  id<RTCI420Buffer> buffer = [frame.buffer toI420];

  const int chromaWidth = buffer.chromaWidth;
  const int chromaHeight = buffer.chromaHeight;
  if (buffer.strideY != frame.width || buffer.strideU != chromaWidth ||
      buffer.strideV != chromaWidth) {
    _planeBuffer.resize(buffer.width * buffer.height);
  }

  [self uploadPlane:buffer.dataY
            texture:self.yTexture
              width:buffer.width
             height:buffer.height
             stride:buffer.strideY];

  [self uploadPlane:buffer.dataU
            texture:self.uTexture
              width:chromaWidth
             height:chromaHeight
             stride:buffer.strideU];

  [self uploadPlane:buffer.dataV
            texture:self.vTexture
              width:chromaWidth
             height:chromaHeight
             stride:buffer.strideV];
}
```

> ##### RTCDefaultShader.mm

```
- (void)applyShadingForFrameWithWidth:(int)width
                               height:(int)height
                             rotation:(RTCVideoRotation)rotation
                               yPlane:(GLuint)yPlane
                               uPlane:(GLuint)uPlane
                               vPlane:(GLuint)vPlane {
  if (![self prepareVertexBufferWithRotation:rotation]) {
    return;
  }

  if (!_i420Program && ![self createAndSetupI420Program]) {
    RTCLog(@"Failed to setup I420 program");
    return;
  }

  glUseProgram(_i420Program);

  glActiveTexture(static_cast<GLenum>(GL_TEXTURE0 + kYTextureUnit));
  glBindTexture(GL_TEXTURE_2D, yPlane);

  glActiveTexture(static_cast<GLenum>(GL_TEXTURE0 + kUTextureUnit));
  glBindTexture(GL_TEXTURE_2D, uPlane);

  glActiveTexture(static_cast<GLenum>(GL_TEXTURE0 + kVTextureUnit));
  glBindTexture(GL_TEXTURE_2D, vPlane);

  glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}
```

> ### 渲染的调用逻辑

渲染的实现逻辑，可以通过加 `断点` 的方式来查看。

![pic-1](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-8-render-video-with-opengl/pic-1.png)

![pic-2](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-8-render-video-with-opengl/pic-2.png)

![pic-3](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-8-render-video-with-opengl/pic-3.png)

![pic-4](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-8-render-video-with-opengl/pic-4.png)






