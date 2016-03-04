//
//  FJAllTableViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/25.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJAllTableViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "FJTopic.h"
#import <SVProgressHUD.h>

#import "FJTopicCell.h"


@interface FJAllTableViewController ()

/** 请求管理者*/
@property (nonatomic ,strong) AFHTTPSessionManager *mgr;
/** 保存topic数据*/
@property (nonatomic ,strong) NSMutableArray<FJTopic *> *topics;
/** 当前最后一个帖子的描述信息,用于加载下一页数据*/
@property (nonatomic ,copy)NSString *maxtime;

/**** footer ***/
/** 上拉刷新view*/
@property (nonatomic ,weak) UIView *footerV;
/** 上拉刷新textlabel*/
@property (nonatomic ,weak) UILabel *footLabel;
/** 刷新状态*/
@property (nonatomic ,assign,getter=isFooterRefreshing) BOOL footerRefreshing;

/**** header ***/
/** 下拉刷新view*/
@property (nonatomic ,weak) UIView *headerV;
/** 下拉刷新textlabel*/
@property (nonatomic ,weak) UILabel *headLabel;
/** 刷新状态*/
@property (nonatomic ,assign,getter=isHeaderRefreshing) BOOL headerRefreshing;

@end

@implementation FJAllTableViewController

static NSString * const FJTopicCellID = @"FJTopicCellID";


#pragma mark - lazy
-(AFHTTPSessionManager *)mgr{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJTopicCell class]) bundle:nil] forCellReuseIdentifier:FJTopicCellID];
    
    //设置cell估算高度
    self.tableView.estimatedRowHeight = 160;
    
    self.tableView.backgroundColor = FJColor(215, 215, 215);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置头部和底部区域
    self.tableView.contentInset = UIEdgeInsetsMake(FJNavBarMaxY + FJTitlesViewH, 0, FJTabBarH, 0);
    //设置滚动条滚动范围
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //创建通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:@"FJTabBarButtonDidRepeatClickedNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:@"FJTitleButtonDidRepeatClickedNotification" object:nil];
    
    
    //加载上拉刷新控件
    [self setUpRefresh];
    
}

-(void)setUpRefresh{
    
    //广告条
    UILabel *adLabel = [[UILabel alloc] init];
    adLabel.frame = CGRectMake(0, 0, self.tableView.width, 25);
    adLabel.text =@"广告条";
    adLabel.backgroundColor = [UIColor blueColor];
    self.tableView.tableHeaderView = adLabel;
    
    //header下拉刷新
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, -50, self.tableView.width, 50);
    [self.tableView addSubview:header];
    self.headerV = header;
    
    UILabel *headLabel = [[UILabel alloc] init];
    headLabel.frame = header.bounds;
    headLabel.backgroundColor = [UIColor redColor];
    headLabel.text = @"上拉加载更多";
    headLabel.textColor = [UIColor whiteColor];
    headLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:headLabel];
    self.headLabel = headLabel;
    
    //header自动进行刷新
    [self headerBeginRefreshing];
    
    
    //footer上拉刷新view
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.width, 35);
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    self.footerV = footer;
    
    UILabel *footLabel = [[UILabel alloc] init];
    footLabel.frame = footer.bounds;
    footLabel.backgroundColor = [UIColor redColor];
    footLabel.text = @"上拉加载更多";
    footLabel.textColor = [UIColor whiteColor];
    footLabel.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footLabel];
    self.footLabel = footLabel;
    
    
}

/**
 *  加载最新帖子数据
 */
-(void)loadNewTopics{
    
    //取消请求-防止请求重复
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    //加载新的网络请求

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(FJTopicTypeAll);
    
    //发送get请求
    [self.mgr GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //储存当前maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [FJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self headerEndRefreshing];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //结束刷新
        [self headerEndRefreshing];
        if (error.code == NSURLErrorCancelled) {
            FJLog(@"任务被取消了");
        }else{
            [SVProgressHUD showErrorWithStatus:@"网络不给力,请稍后再试"];
        }
        
    }];

    
}
/**
 *  加载更多帖子数据
 */
-(void)loadMoreTopics{
    
    //取消请求-防止请求重复
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    //加载更多网络请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(FJTopicTypeAll);
    parameters[@"maxtime"] = self.maxtime;
    
    //发送get请求
    [self.mgr GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //储存当前maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *moreTopic = [FJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:moreTopic];
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self footerEndRefreshing];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        //结束刷新
        [self footerEndRefreshing];

    }];
    
    
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
    
    //进入刷新状态
    [self headerBeginRefreshing];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.footerV.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    FJTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:FJTopicCellID];

    
    //取出模型数据
    cell.topic = self.topics[indexPath.row];
    
    
    return cell;
}

//设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.topics[indexPath.row].cellHeight;
}

#pragma mark - scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

    //处理header
    [self dealHeader];
    //处理footer
    [self dealFooter];
    
    //清除缓存
    [[SDImageCache sharedImageCache] clearMemory];
}
/**
 *  手松开时调用
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //如果正在刷新,直接返回
    if (self.isHeaderRefreshing) return;
    
    //如果偏移量 <= offsetY, 就说明header已经完全出现
    CGFloat offsetY = -(self.tableView.contentInset.top + self.headerV.height);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        
        [self headerBeginRefreshing];
    }

}
-(void)dealHeader{
    
    //如果header没有创建直接返回
    if (self.headerV == 0) return;
    //如果header正在刷新,直接返回
    if (self.isHeaderRefreshing) return;
    
    //计算偏移量,如果偏移量 <= offsetY, 就说明header已经完全出现
    CGFloat offsetY = -(self.tableView.contentInset.top + self.headerV.height);
    if (self.tableView.contentOffset.y <= offsetY) {
        self.headLabel.text = @"松开立即刷新";
        self.headLabel.backgroundColor = [UIColor greenColor];
        
    }else{
        self.headLabel.text = @"下拉可以刷新";
        self.headLabel.backgroundColor = [UIColor redColor];
    }
    
}
-(void)dealFooter{
    //如果没有数据直接返回
    if (self.topics.count == 0) return;
    //如果正在上拉刷新,直接返回
    if (self.footerRefreshing) return;
    
    //计算Y方向偏移量,如果偏移量 >= offsetY, 就说明footer已经完全出现
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.height;
    if (self.tableView.contentOffset.y >= offsetY) {
        [self footerBeginRefreshing];
    }

}

#pragma mark - header
-(void)headerBeginRefreshing{
    //如果当前正在下拉刷新数据,直接返回
    if (self.headerRefreshing) return;
    
    //进入刷新状态
    self.headLabel.text =@"正在刷新数据...";
    self.headLabel.backgroundColor = [UIColor orangeColor];
    self.headerRefreshing = YES;
    
    //增大内边局,保持刷新状态
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.headerV.height;
        self.tableView.contentInset = inset;
        
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -inset.top);
    }];
    
    //加载最新帖子数据
    [self loadNewTopics];
    
}
-(void)headerEndRefreshing{
    
    self.headerRefreshing = NO;
    
    //修复内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.headerV.height;
        self.tableView.contentInset = inset;

    }];
    
}

#pragma mark - footer
-(void)footerBeginRefreshing{
    self.footLabel.text = @"正在加载加载更多...";
    //记录上拉刷新状态
    self.footerRefreshing = YES;
    //加载更多数据
    [self loadMoreTopics];
}
-(void)footerEndRefreshing{
    self.footLabel.text = @"上拉可以加载更多";
    //记录上拉刷新状态
    self.footerRefreshing = NO;
}
@end
