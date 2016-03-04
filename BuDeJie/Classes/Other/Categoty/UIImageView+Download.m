//
//  UIImageView+Download.m
//  BuDeJie
//
//  Created by Francis on 16/3/3.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "UIImageView+Download.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@implementation UIImageView (Download)

-(void)fj_setLargeImageImageUrl:(NSString *)largeImageUrl smallImageUrl:(NSString *)smallImageUrl placeHolder:(UIImage *)placeHolder{
    //1.调试模式代码---真机调试时需注释
    [self sd_setImageWithURL:[NSURL URLWithString:largeImageUrl] placeholderImage:placeHolder];
    //2.真机模式代码---调试时需注释
   /*
    //2.1检查缓存中是否有大图
    UIImage *largeImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:largeImageUrl];
    if (largeImage) {
        self.image = largeImage;
    }else{
        //2.2下载图片
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        if (mgr.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:largeImageUrl] placeholderImage:placeHolder];
        }else if (mgr.isReachableViaWWAN){
            [self sd_setImageWithURL:[NSURL URLWithString:smallImageUrl] placeholderImage:placeHolder];
        }else{
            self.image = placeHolder;
        }
    }
    */
}

- (void)fj_setHeader:(NSString *)url{
    
    UIImage *placeHolder = [UIImage fj_circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return ;
        self.image = [image fj_circleImage];
    }];
}

@end
