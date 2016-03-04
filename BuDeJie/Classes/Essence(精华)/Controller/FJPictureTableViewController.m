//
//  FJPictureTableViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/25.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJPictureTableViewController.h"

@interface FJPictureTableViewController ()

@end

@implementation FJPictureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.tableView.backgroundColor = FJRandomColor;
    
    //设置头部和底部区域
    self.tableView.contentInset = UIEdgeInsetsMake(FJNavBarMaxY + FJTitlesViewH, 0, FJTabBarH, 0);
    //设置滚动条滚动范围
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //创建通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:@"FJTabBarButtonDidRepeatClickedNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:@"FJTitleButtonDidRepeatClickedNotification" object:nil];
    
}

-(void)dealloc{
    //创建通知观察者后需要移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 监听titleButton的重复点击
-(void)titleButtonDidRepeatClick{
    
    [self tabBarButtonDidRepeatClick];
}


#pragma mark - 监听tabBar按钮的重复点击
-(void)tabBarButtonDidRepeatClick{
    //如果当前控制器的view不再window上面,直接返回
    if (self.tableView.window == nil) return;
    //如果当前控制器的View没有和window重叠,直接返回
    if (self.tableView.scrollsToTop == NO) return;
    
    FJLog(@"tabbar按钮重复点击,%@---刷新数据",self.class);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = self.tableView.backgroundColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%ld",self.class,(long)indexPath.row];
    
    return cell;
}

@end
