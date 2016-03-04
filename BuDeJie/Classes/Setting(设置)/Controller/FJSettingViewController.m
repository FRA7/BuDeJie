//
//  FJSettingViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJSettingViewController.h"
#import <SDImageCache.h>
#import "FJCacheManager.h"
#import <SVProgressHUD.h>

//缓存路径
#define FJCachePath (NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0])

@interface FJSettingViewController ()
/** 缓存大小*/
@property (nonatomic ,assign) NSInteger totalSize;

@end

@implementation FJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:UIBarButtonItemStylePlain target:self action:@selector(jump)];
    
    [SVProgressHUD showWithStatus:@"正在计算"];
    
    [FJCacheManager getCacheSizeWithDirectoryPath:FJCachePath completion:^(NSInteger totalSize) {
       
        [SVProgressHUD dismiss];
        
        _totalSize = totalSize;
        
        [self.tableView reloadData];
        
    }];
    
    
}
-(void)jump{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor cyanColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    cell.textLabel.text = [self getCacheSize];
    return cell;
}

//获取缓存尺寸字符串
-(NSString *)getCacheSize{
    
    NSInteger size = _totalSize;
    NSString *cacheString = @"清除缓存";
    
    if (size > 1000 * 1000) {//MB
        CGFloat sizeMB = size / (1000 * 1000);
        cacheString = [NSString stringWithFormat:@"%@(%.1fMB)",cacheString,sizeMB];
    }else if (size > 1000){
        CGFloat sizeKB = size / 1000;
        cacheString = [NSString stringWithFormat:@"%@(%.1fKB)",cacheString,sizeKB];
    }else if (size > 0){
        cacheString = [NSString stringWithFormat:@"%@(%ldB)",cacheString,size];
    }
    
    //如果缓存为0,直接返回文字标题
    return [cacheString stringByReplacingOccurrencesOfString:@".0" withString:@""];
}


//点击cell调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [FJCacheManager removeDirectoryPath:FJCachePath];
    
    //清除缓存后将totalsize复位
    _totalSize = 0;
    
    //刷新cell
    [self.tableView reloadData];
    
}
@end
