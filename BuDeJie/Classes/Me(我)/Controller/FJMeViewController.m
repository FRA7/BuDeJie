//
//  FJMeViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJMeViewController.h"
#import "FJSettingViewController.h"
#import "FJSquareCell.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import "FJSquareItem.h"
#import "FJWebViewController.h"

static NSString * const ID = @"collectionCell";

static int const cols = 4;

static CGFloat const margin = 0.5;

#define FJCellW (FJScreenW - (cols-1) *margin) / cols

@interface FJMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic ,strong) NSMutableArray *squareList;

@property (nonatomic ,strong) UICollectionView *collectionView;

@end

@implementation FJMeViewController

#pragma mark - lazy
-(NSMutableArray *)squareList{
    if (_squareList == nil) {
        
        _squareList = [[NSMutableArray alloc] init];
    }
    return _squareList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpNavgationItem];
    
    [self loadCollectionView];
    
    [self loadSquareData];
    
    //设置tableview间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}

-(void)loadCollectionView{
    //加载UICollectionView
    //创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];


    layout.itemSize = CGSizeMake(FJCellW, FJCellW);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    //创建collectionView
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    
    self.collectionView = collectionV;
    
    collectionV.backgroundColor = FJColor(200, 200, 200);
    
    collectionV.dataSource = self;
    
    self.collectionView.delegate = self;
    
    self.collectionView.scrollEnabled = NO;
    
    //如果注释,则collectionView不会加载到tableVeiw上
    self.tableView.tableFooterView = collectionV;
    
    //注册cell
    [collectionV registerNib:[UINib nibWithNibName:@"FJSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];

}
-(void)loadSquareData{
    //加载网络请求
 
    //创建会话管理者
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];

    NSString *baseUrl = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"square";

    parameters[@"c"] = @"topic";
    
    //发送get请求
    [sessionManager GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        //成功调用-解析数据
                NSDictionary *dict = responseObject[@"square_list"];
        
//        [responseObject writeToFile:@"/Users/francis/Documents/Developer/800-实用技术/百思不得姐/05.我的界面/29.展示方块界面:加载数据/BuDeJie/square.plist" atomically:YES];
        _squareList = [FJSquareItem mj_objectArrayWithKeyValuesArray:dict];
        
        [self resoveData];
        
        //计算总行数
        NSInteger rows = (_squareList.count-1) / cols +1;
        
        //计算collectionView的高度
        CGFloat collectionHeight = rows * FJCellW;
        
        self.collectionView.height = collectionHeight;
        
        self.tableView.tableFooterView = self.collectionView;
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败调用
        NSLog(@"%@",error);
        
    }];
    
}

-(void)resoveData{
    
    NSInteger count = _squareList.count;
    
    int extre = count % cols;
    
    if (extre) {
        extre = cols - extre;
    }
    
    for (int i = 0; i < extre; i++) {
        FJSquareItem *sItem = [[FJSquareItem alloc] init];
        [self.squareList addObject:sItem];
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.squareList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //从缓存中取出cell
    FJSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.squareList[indexPath.row];
    
//    cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FJWebViewController *webVC = [[FJWebViewController alloc] init];
    
    webVC.hidesBottomBarWhenPushed = YES;
    //获取collectionCell
    FJSquareItem *item = self.squareList[indexPath.row];
    //设置请求地址
    webVC.url = [NSURL URLWithString:item.url];
    
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)setUpNavgationItem{
    //设置title
    self.navigationItem.title = @"我的";
    //设置右边导航按钮
    UIBarButtonItem *nightButton = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] targer:self action:@selector(nightButtonClick:)];
    UIBarButtonItem *setButton = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] targer:self action:@selector(setButtonClick)];
    
    self.navigationItem.rightBarButtonItems = @[setButton,nightButton];
    
    
}
//夜晚模式点击
-(void)nightButtonClick:(UIButton *)button{
    button.selected = !button.selected;
}
//设置按钮点击
-(void)setButtonClick{

    //进入设置界面
    FJSettingViewController *settingVC = [[FJSettingViewController alloc] init];
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}
@end
