//
//  FJFastLoginView.m
//  BuDeJie
//
//  Created by Francis on 16/2/21.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJFastLoginView.h"

@implementation FJFastLoginView

+(instancetype)fastLoginView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

@end
