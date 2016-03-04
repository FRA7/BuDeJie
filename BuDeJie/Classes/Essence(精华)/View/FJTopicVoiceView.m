//
//  FJTopicVoiceView.m
//  BuDeJie
//
//  Created by Francis on 16/3/2.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJTopicVoiceView.h"
#import "FJTopic.h"
#import <UIImageView+WebCache.h>

@interface FJTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@end
@implementation FJTopicVoiceView

-(void)setTopic:(FJTopic *)topic{
    _topic = topic;
    
    //设置声音图片
    [self.imageView fj_setLargeImageImageUrl:topic.image1 smallImageUrl:topic.image0 placeHolder:nil];

    //设置播放次数
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万次播放",topic.playcount / 10000.0];
    }else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    }
    //设置视频时长
    NSInteger minutes = topic.voicetime / 60;
    NSInteger seconds = topic.voicetime % 60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minutes,seconds];
    
}

@end
