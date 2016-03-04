//
//  FJTopic.h
//  BuDeJie
//
//  Created by Francis on 2/28/16.
//  Copyright © 2016 FRAJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FJTopicType) {
    /** 全部 */
    FJTopicTypeAll = 1,
    /** 图片 */
    FJTopicTypePicture = 10,
    /** 段子 */
    FJTopicTypeWord = 29,
    /** 声音 */
    FJTopicTypeVoice = 31,
    /** 视频 */
    FJTopicTypeVideo = 41
    
};

@interface FJTopic : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 帖子类型*/
@property (nonatomic ,assign) FJTopicType type;
/** 图片的高度*/
@property (nonatomic ,assign) CGFloat height;
/** 图片的宽度*/
@property (nonatomic ,assign) CGFloat width;
/** 小图*/
@property (nonatomic ,copy)NSString *image0;
/** 中图*/
@property (nonatomic ,copy)NSString *image2;
/** 大图*/
@property (nonatomic ,copy)NSString *image1;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 是否为动态图*/
@property (nonatomic ,assign) BOOL is_gif;
/** 最热评论*/
@property (nonatomic ,strong) NSArray *top_cmt;

//额外增加的属性
/** 根据当前cell类型计算出的cell高度*/
@property (nonatomic ,assign) CGFloat cellHeight;
/** 帖子的frame*/
@property (nonatomic ,assign) CGRect middleFrame;
/** 是否是大图*/
@property (nonatomic ,assign,getter=isBigPicture) BOOL bigPicture;

@end
