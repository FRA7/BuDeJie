//
//  FJCacheManager.h
//  BuDeJie
//
//  Created by Francis on 16/2/23.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJCacheManager : NSObject

+(void)getCacheSizeWithDirectoryPath:(NSString *)directoryPath completion:(void(^)(NSInteger))completionBlock;

+(void)removeDirectoryPath:(NSString *)directoryPath;
@end
