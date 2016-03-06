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
/** <#注释#>*/
@property (nonatomic ,weak) UIImageView *imageView;


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
    self.imageView = imageView;
    
    //缩放
    CGFloat maxScale = self.topic.width / imageW;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;

    }
    
}
- (IBAction)save{

    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    //判断当前的授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
           
            // 这是系统级别的限制（比如家长控制），用户也无法修改这个授权状态
            case PHAuthorizationStatusRestricted:{
                [SVProgressHUD showErrorWithStatus:@"使用权限如家长控制原因,无法保存图片"];
                break;
            }
            // 用户已经拒绝当前App访问相片数据（说明用户当初选择了“Don't Allow”）
            case PHAuthorizationStatusDenied:{
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    NSLog(@"提醒用户打开访问权限开关");
                }
                break;
            }
            // 用户已经允许当前App访问相片数据（说明用户当初选择了“OK”）
            case PHAuthorizationStatusAuthorized:{
                [self saveImage];
                break;
            }
                
            default:
                break;
        }
    }];

    
}

-(void)saveImage{
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 保存图片到【相机胶卷】 - 添加一个新的PHAsset对象
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
        
        // 从Info.plist中获得App名称
        NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
        // 拥有一个【自定义相册】
        [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
    
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"%zd",success);
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
