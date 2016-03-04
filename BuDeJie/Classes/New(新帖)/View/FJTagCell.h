//
//  FJTagCell.h
//  BuDeJie
//
//  Created by Francis on 16/2/20.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJTagItem;
@interface FJTagCell : UITableViewCell
/** 标签*/
@property (nonatomic ,strong)FJTagItem *tagItem;
@end
