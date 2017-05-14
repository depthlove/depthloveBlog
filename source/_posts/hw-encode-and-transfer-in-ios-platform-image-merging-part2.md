---
title: 在iOS上硬编码推流－图像融合（二）
date: 2016-03-18 14:52:50
tags:
- 音视频处理
- iOS中高级开发
---

采用UIGraphics将两幅图绘制到同一个画布上输出，达到图像融合的简单效果。

<!-- more -->

```
    UIImage *supermanImage = [UIImage imageNamed:@"superman.png"];
    UIImage *moneyImage = [UIImage imageNamed:@"money.png"];
    
    CGSize supermanSize = [supermanImage size];
    CGSize moneySize = [moneyImage size];
    
//    NSLog(@"s : %f,%f \n m : %f,%f", supermanSize.width, supermanSize.height, moneySize.width, moneySize.height);
    
    UIGraphicsBeginImageContext(supermanSize);
    
    [supermanImage drawInRect:CGRectMake(0, 0, supermanSize.width, supermanSize.height)];
    [moneyImage drawInRect:CGRectMake(0, 0, moneySize.width, moneySize.height)];
    
    UIImage *mergeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    mergeImageView = [[UIImageView alloc] init];
    mergeImageView.image = mergeImage;
    mergeImageView.frame = self.view.bounds;
    [self.view addSubview:mergeImageView];
```

demo地址：[https://github.com/depthlove/STMImageMerging](https://github.com/depthlove/STMImageMerging)
