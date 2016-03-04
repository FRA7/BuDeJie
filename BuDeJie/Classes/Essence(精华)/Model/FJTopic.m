//
//  FJTopic.m
//  BuDeJie
//
//  Created by Francis on 2/28/16.
//  Copyright © 2016 FRAJ. All rights reserved.
//

#import "FJTopic.h"

@implementation FJTopic

-(CGFloat)cellHeight{
    
    //如果cellHeight计算过了,直接返回
    if (_cellHeight) return _cellHeight;
     /****************** 计算cell的高度 - begin ******************/
    //头像
    _cellHeight += 55;
    
    //文字
    CGFloat textW = FJScreenW - 2 * FJMargin;
    CGSize textMaxSize = CGSizeMake(textW, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight += FJMargin;
    //中间内容
    if (self.type != FJTopicTypeWord) {
        
        CGFloat middleW = textW;
        CGFloat middleH = middleW * self.height / self.width;
        //判断是否是超长图片
        if (middleH >= FJScreenH) {
            middleH = 200;
            self.bigPicture = YES;
        }
        CGFloat middleX = FJMargin;
        CGFloat middleY = _cellHeight;
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        
     

        _cellHeight += middleH + FJMargin;

    }

    //最热评论
    if (self.top_cmt.count) {
        _cellHeight += 18;
        
        NSDictionary *dict = self.top_cmt.firstObject;
        
        NSString *content = dict[@"content"];
        
        if (content.length == 0) {  //语音评论
            content = @"[语音评论]";
        }
        
        NSString *username = dict[@"user"][@"username"];
        NSString *topCmtLabel = [NSString stringWithFormat:@"%@ : %@",username,content];
        _cellHeight += [topCmtLabel boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight += FJMargin;
    }
    
    
    //工具条
    _cellHeight += 35 + FJMargin;
     /****************** 计算cell的高度 - end ******************/
    return _cellHeight;
    
}
@end
