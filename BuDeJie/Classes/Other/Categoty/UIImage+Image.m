//
//  UIImage+Image.m
//  BuDeJie
//
//  Created by FRAJ on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)imageNameWithOriginalMode:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    // imageWithRenderingMode:返回一个没有被渲染的图片
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+(instancetype)fj_circleImageNamed:(NSString *)name{
    
    return [[self imageNamed:name] fj_circleImage];
}

-(instancetype)fj_circleImage{
    
    //1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.描述剪裁区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //3.设置剪裁区域
    [clipPath addClip];
    //4.绘制图片
    [self drawAtPoint:CGPointZero];
    //5.从上下文中取出图片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}

@end
