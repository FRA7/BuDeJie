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


@end
