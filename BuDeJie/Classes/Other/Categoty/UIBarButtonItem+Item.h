//
//  UIBarButtonItem+Item.h
//  BuDeJie
//
//  Created by FRAJ on 15/11/13.
//  Copyright © 2015年 FRAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

+ (instancetype)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage targer:(id)target action:(SEL)action;

+ (instancetype)barButtonItemWithImage:(UIImage *)image selImage:(UIImage *)selImage targer:(id)target action:(SEL)action;

@end
