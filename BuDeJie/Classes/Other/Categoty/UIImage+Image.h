//
//  UIImage+Image.h
//  BuDeJie
//
//  Created by FRAJ on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
/**
 *  加载一个没有被渲染图片
 *
 *  @param imageName 图片名称
 *
 *  @return 返回一个没有渲染图片
 */
+ (UIImage *)imageNameWithOriginalMode:(NSString *)imageName;

@end
