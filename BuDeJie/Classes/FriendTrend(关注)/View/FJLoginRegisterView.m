//
//  FJLoginRegisterView.m
//  BuDeJie
//
//  Created by Francis on 16/2/20.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJLoginRegisterView.h"

@implementation FJLoginRegisterView


+(instancetype)loginView{
    return [[[NSBundle mainBundle] loadNibNamed:@"FJLoginRegisterView" owner:nil options:nil] firstObject];
}

+(instancetype)registerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"FJLoginRegisterView" owner:nil options:nil] lastObject];
}
@end
