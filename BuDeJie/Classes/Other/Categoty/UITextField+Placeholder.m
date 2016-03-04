//
//  UITextField+Placeholder.m
//  01-BuDeJie
//
//  Created by yz on 15/12/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "UITextField+Placeholder.h"

#import <objc/message.h>


NSString * const placeholderColorName = @"placeholderColor";

@implementation UITextField (Placeholder)

+ (void)load
{
    Method placeholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method bs_placeholderMethod = class_getInstanceMethod(self, @selector(bs_setPlaceholder:));
    method_exchangeImplementations(placeholderMethod, bs_placeholderMethod);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    UILabel *placeLabel = [self valueForKeyPath:@"placeholderLabel"];
    
    placeLabel.textColor = placeholderColor;
    
    objc_setAssociatedObject(self, (__bridge const void *)(placeholderColorName), placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)placeholderColor
{

    return objc_getAssociatedObject(self, (__bridge const void *)(placeholderColorName));

}

- (void)bs_setPlaceholder:(NSString *)placeholder
{
    
    [self bs_setPlaceholder:placeholder];
    
    self.placeholderColor = self.placeholderColor;
}

@end
