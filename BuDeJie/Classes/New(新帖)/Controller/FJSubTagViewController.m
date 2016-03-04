//
//  FJSubTagViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/20.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJSubTagViewController.h"
#import <AFNetworking.h>
#import "FJTagItem.h"
#import <MJExtension.h>
#import "FJTagCell.h"
#import <SVProgressHUD.h>

@interface FJSubTagViewController ()
/** 订阅标签*/
@property (nonatomic ,strong) NSArray *tags;

@property (nonatomic ,strong) AFHTTPSessionManager *sesManager;

@end

@implementation FJSubTagViewController
static NSString * const ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐订阅";
    
    [self loadTags];
 
    [self setUpTableView];
}

-(void)loadTags{
    //加载广告网络请求
    //弹出提示器告诉用户
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    //创建会话管理者
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    self.sesManager = sessionManager;
    
    NSString *baseUrl = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    //发送get请求
    [sessionManager GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        //成功调用-解析数据
//        NSDictionary *dict = responseObject[@"def_tags"];
        
        _tags = [FJTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败调用
        NSLog(@"%@",error);
        
        //隐藏指示器
        [SVProgressHUD dismiss];
    }];

    
}
-(void)setUpTableView{
    //注册cell,绑定ID标识
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJTagCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    //设置行高
    self.tableView.rowHeight = 70;
    //去掉系统分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置背景颜色
    self.tableView.backgroundColor = FJColor(200, 200, 200);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    //停止下载
    [self.sesManager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //隐藏指示器
    [SVProgressHUD dismiss];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tags.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    FJTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //设置数据,获取cell内容
    cell.tagItem = _tags[indexPath.row];
    
    return cell;
}

//设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
@end
