//
//  FJTopicCell.m
//  BuDeJie
//
//  Created by Francis on 2/29/16.
//  Copyright © 2016 FRAJ. All rights reserved.
//

#import "FJTopicCell.h"
#import "FJTopic.h"
#import <UIImageView+WebCache.h>

#import "FJTopicVideoView.h"
#import "FJTopicPictureView.h"
#import "FJTopicVoiceView.h"

@interface FJTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

//最热评论控件
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
//最热评论内容
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;


//中间控件
/** 图片*/
@property (nonatomic ,weak) FJTopicPictureView *picvuteView;
/** 视频*/
@property (nonatomic ,weak) FJTopicVideoView *videoView;
/** 声音*/
@property (nonatomic ,weak) FJTopicVoiceView *voiceView;


@end

@implementation FJTopicCell

#pragma mark - lazy
-(FJTopicPictureView *)picvuteView{
    if (_picvuteView == nil) {
        _picvuteView = [FJTopicPictureView viewForXib];
        [self.contentView addSubview:_picvuteView];
    }
    return _picvuteView;
}
-(FJTopicVideoView *)videoView{
    if (_videoView == nil) {
        _videoView = [FJTopicVideoView viewForXib];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}
-(FJTopicVoiceView *)voiceView{
    if (_voiceView == nil) {
        _voiceView = [FJTopicVoiceView viewForXib];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

-(void)awakeFromNib{
    
    //设置cell背景图片
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
}

-(void)setTopic:(FJTopic *)topic{
    _topic = topic;
    
    [self.profileImageView fj_setHeader:topic.profile_image];
    
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    
    //设置底部工具条按钮文字
    [self setUpButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setUpButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setUpButton:self.repostButton number:topic.repost placeholder:@"转发"];
    [self setUpButton:self.commentButton number:topic.comment placeholder:@"评论"];

    //添加中间内容
    if (topic.type == FJTopicTypePicture) {
        self.picvuteView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.picvuteView.topic = topic;
    }else if (topic.type == FJTopicTypeVideo){
        self.picvuteView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.topic = topic;
    }else if (topic.type == FJTopicTypeVoice){
        self.picvuteView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
    }else if (topic.type == FJTopicTypeWord){
        self.picvuteView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    
    //最热评论
    if (topic.top_cmt.count) {
        self.topCmtView.hidden = NO;
        NSDictionary *dict = topic.top_cmt.firstObject;
        
        
//        NSLog(@"%@----------",topic.top_cmt.count);//----------------------------
        
        
        NSString *content = dict[@"content"];
        
        if (content.length == 0) {  //语音评论
            content = @"[语音评论]";
        }
        NSString *username = dict[@"user"][@"username"];
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
    }else{
        self.topCmtView.hidden = YES;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.topic.type == FJTopicTypePicture) {
        self.picvuteView.frame = self.topic.middleFrame;
    }else if (self.topic.type == FJTopicTypeVideo){
        self.videoView.frame = self.topic.middleFrame;
    }else if (self.topic.type == FJTopicTypeVoice){
        self.voiceView.frame = self.topic.middleFrame;
    }
    
}

/**
 *  设置按钮数字
 *
 *  @param button      当前按钮
 *  @param number      按钮显示的文字
 *  @param placeholder 当前占位元素---placeholder为中文,放在最后方便使用点语法
 */
-(void)setUpButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder{
    
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number >= 0){
        [button setTitle:[NSString stringWithFormat:@"%.zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder  forState:UIControlStateNormal];
    }
}

-(void)setFrame:(CGRect)frame{
    //设置cell间隙
    frame.size.height -= FJMargin;
    [super setFrame:frame];
}
@end
