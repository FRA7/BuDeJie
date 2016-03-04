//
//  GlobalConst.m
//  BuDeJie
//
//  Created by Francis on 16/2/27.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "GlobalConst.h"

/******  请求路径  ****/
NSString * const baseUrl = @"http://api.budejie.com/api/api_open.php";

/******  重复点击tabbar按钮的通知  ****/
NSString * const FJTabBarButtonDidRepeatClickedNotification = @"FJTabBarButtonDidRepeatClickedNotification";

/******  重复点击标题栏按钮的通知  ****/
NSString * const FJTitleButtonDidRepeatClickedNotification = @"FJTitleButtonDidRepeatClickedNotification";

/******  UITabBar的高度  ****/
CGFloat const FJTabBarH = 49;

/******  标题栏高度  ****/
CGFloat const FJTitlesViewH = 35;

/******  导航栏的最大Y值  ****/
CGFloat const FJNavBarMaxY = 64;

/******  全局统一间距  ****/
CGFloat const FJMargin = 10;
