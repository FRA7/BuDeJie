//
//  FJTagItem.h
//  BuDeJie
//
//  Created by Francis on 16/2/20.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJTagItem : NSObject

@property (nonatomic ,strong) NSString *image_list;

@property (nonatomic ,assign) NSInteger *is_default;

@property (nonatomic ,assign) NSInteger *is_sub;

@property (nonatomic ,strong) NSString *sub_number;

@property (nonatomic ,strong) NSString *theme_id;

@property (nonatomic ,strong) NSString *theme_name;

@end
