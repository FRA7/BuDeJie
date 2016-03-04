//
//  FJTabBar.m
//  BuDeJie
//
//  Created by Francis on 16/2/19.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJTabBar.h"

@interface FJTabBar()

@property (nonatomic ,weak) UIButton *addButton;
/** 记录上一次被点击按钮的tag*/
@property (nonatomic ,assign) NSInteger previousClickedTabBarButtonTag;


@end

@implementation FJTabBar

#pragma mark - lazy
-(UIButton *)addButton{
    if (_addButton == nil) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        //设置尺寸和图片大小自适应
        [addButton sizeToFit];
        
        [self addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    
    //调整内部子控件位置
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width / (count + 1);
    CGFloat btnH = self.frame.size.height;
    
    NSInteger i = 0;
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 2) {
                i +=1;
            }
            btnX = i * btnW;
            
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            tabBarButton.tag = i;
            
            i++;
            
            //监听tabBar点击
            [tabBarButton addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    //设置加号按钮位置
    self.addButton.centerX= self.frame.size.width / 2;
    self.addButton.centerY = self.frame.size.height / 2;
    
}


#pragma mark - 监听按钮点击
-(void)tabbarButtonClick:(UIControl *)tabBarButton{
    
    if (self.previousClickedTabBarButtonTag == tabBarButton.tag) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FJTabBarButtonDidRepeatClickedNotification" object:nil];
    }
    
    self.previousClickedTabBarButtonTag = tabBarButton.tag;
}
@end
