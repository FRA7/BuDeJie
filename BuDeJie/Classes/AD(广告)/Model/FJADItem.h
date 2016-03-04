//
//  FJADItem.h
//  BuDeJie
//
//  Created by Francis on 16/2/19.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJADItem : NSObject
/** 广告图片*/
@property (nonatomic ,strong) NSString *w_picurl;
/** 点击广告跳转的界面*/
@property (nonatomic ,strong) NSString *ori_curl;

/** 广告图片宽*/
@property (nonatomic ,assign) CGFloat w;
/** 广告图片高*/
@property (nonatomic ,assign) CGFloat h;
@end
