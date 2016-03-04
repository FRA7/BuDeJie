//
//  FJLoginButton.m
//  BuDeJie
//
//  Created by Francis on 16/2/21.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJLoginButton.h"

@implementation FJLoginButton
-(void)awakeFromNib{
    //设置按钮文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews{
    [super layoutSubviews];
   
    
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = 0;
    
//    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 5;
    self.titleLabel.width = self.width;
    //设置按钮文字居中
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self.titleLabel sizeToFit];
    
    
}

//- (CGRect)imageRectForContentRect:(CGRect)contentRect{
//    return CGRectMake(0, 0, self.width, contentRect.size.height);
//}
//
//- (CGRect)titleRectForContentRect:(CGRect)contentRect{
//    return CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 5, self.width, self.height);
//}
@end
