//
//  FJSeeBigPictureViewController.m
//  BuDeJie
//
//  Created by Francis on 16/3/6.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJSeeBigPictureViewController.h"
#import "FJTopic.h"
#import <UIImageView+WebCache.h>

@interface FJSeeBigPictureViewController ()
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@end

@implementation FJSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:scrollView atIndex:0];
    
    //UIImageView
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor greenColor];
    CGFloat imageW = FJScreenW;
    CGFloat imageH = imageW * self.topic.height / self.topic.width;
    CGFloat imageY = 0;
    if (imageH < FJScreenH) {
        imageY = (FJScreenH - imageH) / 2;
    }else{
        scrollView.contentSize = CGSizeMake(0, imageH);
    }
    imageView.frame = CGRectMake(0, imageY, imageW, imageH);
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return ;
        
        self.saveButton.enabled = YES;
    }];
    
    [scrollView addSubview:imageView];
    
    
}
- (IBAction)save{
    FJFunc
}

- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
