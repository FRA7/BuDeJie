//
//  FJCacheManager.m
//  BuDeJie
//
//  Created by Francis on 16/2/23.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJCacheManager.h"

@implementation FJCacheManager

+(void)getCacheSizeWithDirectoryPath:(NSString *)directoryPath completion:(void(^)(NSInteger))completionBlock{
    
    //开启异步任务
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //1.创建文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        //2.获取cache文件夹中所有路径
        //path:文件夹
        //指定一个文件夹路径,就能获取这个文件件下所有子文件路径
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        NSInteger totalSize = 0;
        
        //2.1遍历文件夹中所有子文件路径
        for (NSString *subPath in subPaths) {
            //2.2拼接文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            //排除隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            //排除文件夹
            BOOL isDirectory;
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            
            //2.3获取这个文件路径信息
            //attributesOfItemAtPath只能获取文件尺寸,不能获取文件夹尺寸
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            totalSize += [attr fileSize];
        }
        
       //注意:在主线程中调用Block
        dispatch_sync(dispatch_get_main_queue(), ^{
            completionBlock(totalSize);
        });

    });
    
   }

+(void)removeDirectoryPath:(NSString *)directoryPath{
    
    //清除缓存
    //1.创建文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //判断当前文件是否存在,是否是文件夹
    //排除文件夹
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        //创建错误信息
        NSException *except = [NSException exceptionWithName:@"fileError" reason:@"传入文件不存在,或者传入不是文件夹,请传入文件夹路径" userInfo:nil];
        //显示错误信息
        [except raise];
    };
    
    //2.获取文件夹下所有文件路径
    NSArray * contentPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    //3.遍历所有文件
    for (NSString *contentPath in contentPaths) {
        //拼接文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:contentPath];
        //移除项目
        [mgr removeItemAtPath:filePath error:nil];
    }

    
}

@end
