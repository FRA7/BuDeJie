//
//  UIView+Xib.m
//  BuDeJie
//
//  Created by Francis on 16/3/2.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "UIView+Xib.h"

@implementation UIView (Xib)

+(instancetype)viewForXib{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

@end
