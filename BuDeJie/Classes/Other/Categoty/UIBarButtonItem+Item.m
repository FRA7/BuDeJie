//
//  UIBarButtonItem+Item.m
//  BuDeJie
//
//  Created by FRAJ on 15/11/13.
//  Copyright © 2015年 FRAJ. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
+ (instancetype)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage targer:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

+ (instancetype)barButtonItemWithImage:(UIImage *)image selImage:(UIImage *)selImage targer:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
