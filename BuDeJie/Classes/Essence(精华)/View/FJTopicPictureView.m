//
//  FJTopicPictureView.m
//  BuDeJie
//
//  Created by Francis on 16/3/2.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJTopicPictureView.h"
#import "FJTopic.h"
#import <UIImageView+WebCache.h>
#import "FJSeeBigPictureViewController.h"
@interface FJTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@end

@implementation FJTopicPictureView


-(void)awakeFromNib{
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

-(void)seeBigPicture{
    
    FJSeeBigPictureViewController *vc = [[FJSeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:vc animated:YES completion:nil];
}


-(void)setTopic:(FJTopic *)topic{
    _topic = topic;
    
    [self.imageView fj_setLargeImageImageUrl:topic.image1 smallImageUrl:topic.image0 placeHolder:nil];
    
    //当图片不是动图时隐藏gifView
    self.gifView.hidden = !topic.is_gif;
    
    if (topic.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
    
}

@end
