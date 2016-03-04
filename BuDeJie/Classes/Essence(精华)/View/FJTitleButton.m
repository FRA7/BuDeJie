//
//  FJTitleButton.m
//  BuDeJie
//
//  Created by Francis on 16/2/25.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJTitleButton.h"

@implementation FJTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{
    
}

@end
