//
//  FJLoginRegisterField.m
//  BuDeJie
//
//  Created by Francis on 16/2/21.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJLoginRegisterField.h"

@implementation FJLoginRegisterField

-(void)awakeFromNib{
    
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    
//    //设置占位文字颜色
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
//    self.attributedPlaceholder = attrString;
    
    //设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    self.placeholderColor = [UIColor lightGrayColor];
    
    //监听文本框开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
}

-(void)textBegin{
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    
//    //设置占位文字颜色
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
//    self.attributedPlaceholder = attrString;
    self.placeholderColor = [UIColor whiteColor];
}
-(void)textEnd{
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    
//    //设置占位文字颜色
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
//    self.attributedPlaceholder = attrString;
    self.placeholderColor = [UIColor lightGrayColor];
}
@end
