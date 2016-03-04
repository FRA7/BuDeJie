//
//  FJTagCell.m
//  BuDeJie
//
//  Created by Francis on 16/2/20.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJTagCell.h"
#import "FJTagItem.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import "UIImage+Antialias.h"

@interface FJTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end
@implementation FJTagCell



-(void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
}
-(void)setTagItem:(FJTagItem *)tagItem{
    _tagItem = tagItem;
    
    //显示头像,设置占位图片
    [_iconImageView fj_setHeader:tagItem.image_list]; //使用封装框架
    /*
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:tagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //剪裁图片生成一张新的图片
        //开启位图上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        
        //描述剪裁区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        [path addClip];
        
        [image drawAtPoint:CGPointZero];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        //抗锯齿
        _iconImageView.image = image;
        
        //关闭上下文
        UIGraphicsEndImageContext();
        
        // 在周边加一个边框为1的透明像素
//        _iconImageView.image = [image imageAntialias];
        
    }];
    */
    _nameLabel.text = tagItem.theme_name;
    
    //设置订阅数字
    CGFloat subNumber = [_tagItem.sub_number floatValue];
    NSString *subStr = [NSString stringWithFormat:@"%@人订阅",_tagItem.sub_number];
    if (subNumber >= 10000) {
        subNumber = subNumber / 10000.0;
        subStr = [NSString stringWithFormat:@"%.1f万人订阅",subNumber];
    }
    
    _numberLabel.text = subStr;
}
@end
