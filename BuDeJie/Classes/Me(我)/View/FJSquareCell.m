//
//  FJSquareCell.m
//  BuDeJie
//
//  Created by Francis on 16/2/21.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJSquareCell.h"
#import "FJSquareItem.h"
#import <UIImageView+WebCache.h>

@interface FJSquareCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation FJSquareCell


-(void)setItem:(FJSquareItem *)item{
    _item = item;
    
    [_iconImageV sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameLabel.text = item.name;
}
@end
