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
#import <SVProgressHUD.h>
#import <Photos/Photos.h>

@interface FJSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (nonatomic ,weak) UIImageView *imageView;


@end

@implementation FJSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:scrollView atIndex:0];
    
    //UIImageView
    UIImageView *imageView = [[UIImageView alloc] init];

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
    self.imageView = imageView;
    
    //缩放
    CGFloat maxScale = self.topic.width / imageW;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;

    }
    
}

-(IBAction)save{
    
    [self.imageView.image fj_saveToCustomAlbumWithCompletionHandler:^(BOOL success, NSError *error) {
//        NSLog(@"%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更UI
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
            } else {
                [SVProgressHUD showErrorWithStatus:@"保存失败！"];
            }
        });
    }];
    

}

- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}


@end
