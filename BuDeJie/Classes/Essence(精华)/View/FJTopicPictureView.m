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

-(IBAction)seeBigPicture{
    
    FJSeeBigPictureViewController *vc = [[FJSeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:vc animated:YES completion:nil];
}


-(void)setTopic:(FJTopic *)topic{
    _topic = topic;
    
    
    //当图片不是动图时隐藏gifView
    self.gifView.hidden = !topic.is_gif;
    
    if (topic.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
        //解决长图下载宽度问题
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            //目标图片大小
            CGFloat imageW = FJScreenW - 2 * FJMargin;
            CGFloat imageH = imageW * topic.height / topic.width;
            //开启图片上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            //绘制图片
            [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
             
             self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            //关闭上下文
            UIGraphicsEndImageContext();
        }];
    }else{
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
        
        [self.imageView fj_setLargeImageImageUrl:topic.image1 smallImageUrl:topic.image0 placeHolder:nil];

    }
    
}

@end
