//
//  FJEssenceViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJEssenceViewController.h"
#import "FJTitleButton.h"
#import "FJAllTableViewController.h"
#import "FJVideoTableViewController.h"
#import "FJVoiceTableViewController.h"
#import "FJPictureTableViewController.h"
#import "FJWordTableViewController.h"


@interface FJEssenceViewController ()<UIScrollViewDelegate>
/** 标题栏*/
@property (nonatomic ,weak) UIView *titleView;
/** 标题按钮*/
@property (nonatomic ,weak) FJTitleButton *selectedButton;
/** 按钮下划线*/
@property (nonatomic ,weak) UIView *titleButtonUnderLineView;
/** 用来显示所有tableView*/
@property (nonatomic ,weak) UIScrollView *scrollView;

@end

@implementation FJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
    [self setUpNavgationItem];
    
    //加载子控制器
    [self setUpChildViewController];
    
    //加载scrollView
    [self setUpScrollView];
    
    //加载按钮view
    [self setUpTitleView];
    
    //默认添加第1个tableview到scrollView
    [self addChildViewControllerIntoScrollView:0];
    
}

#pragma mark - 设置子控制器
-(void)setUpChildViewController{
    

    [self addChildViewController:[[FJAllTableViewController alloc] init]];

    [self addChildViewController:[[FJVideoTableViewController alloc] init]];

    [self addChildViewController:[[FJVoiceTableViewController alloc] init]];

    [self addChildViewController:[[FJPictureTableViewController alloc] init]];

    [self addChildViewController:[[FJWordTableViewController alloc] init]];
    
}

#pragma mark - 设置标题栏
-(void)setUpTitleView{
    
    UIView *titleV = [[UIView alloc] init];
    titleV.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titleV.frame = CGRectMake(0, FJNavBarMaxY, self.view.width, FJTitlesViewH);
    [self.view addSubview:titleV];
    
    self.titleView = titleV;
    
    //设置标题按钮
    [self setUptitleButton];
    //设置按钮下划线
    [self setUptitleUnderLine];
}

#pragma mark - 设置标题栏按钮
-(void)setUptitleButton{
    
    //按钮名称
    NSArray *buttonTitle = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    //按钮数量
    NSInteger count = buttonTitle.count;
    //创建按钮
    for (NSInteger i = 0; i < count; i++) {
        UIButton *titleBtn = [[FJTitleButton alloc] init];
        
        //保存按钮tag
        titleBtn.tag = i;

        //设置按钮frame
        CGFloat titleBtnW = self.titleView.width / count;
        CGFloat titleBtnH = self.titleView.height;
        CGFloat titleBtnX = titleBtnW * i;
        CGFloat titleBtnY = 0;
        titleBtn.frame = CGRectMake(titleBtnX, titleBtnY, titleBtnW, titleBtnH);
        //为按钮添加事件
        [titleBtn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //设置按钮数据

        [titleBtn setTitle:buttonTitle[i] forState:UIControlStateNormal];
     
        //将按钮添加到标题栏上
        [self.titleView addSubview:titleBtn];
    }
}

#pragma mark - 设置标题栏按钮下划线
-(void)setUptitleUnderLine{
    
    //获取当前选中按钮
    FJTitleButton *firstTItleButton = self.titleView.subviews.firstObject;
    
    UIView *underLineV = [[UIView alloc] init];

    //设置frame
    CGFloat underLineH = 2;
    CGFloat underLineY = self.titleView.height - underLineH;
    CGFloat underLineW = 70;
    
    underLineV.frame = CGRectMake(0, underLineY, underLineW, underLineH);
    
    underLineV.backgroundColor = [firstTItleButton titleColorForState:UIControlStateSelected];
   [self.titleView addSubview:underLineV];
    
    self.titleButtonUnderLineView = underLineV;
    //默认点击最前面的按钮
    [firstTItleButton.titleLabel sizeToFit];//根据屏幕内容自动计算大小
    //切换按钮状态
    firstTItleButton.selected = YES;
    self.selectedButton = firstTItleButton;
    
    //分割线
    self.titleButtonUnderLineView.width = firstTItleButton.titleLabel.width + FJMargin;
    self.titleButtonUnderLineView.centerX = firstTItleButton.centerX;
    
}

#pragma mark - 设置ScrollView
-(void)setUpScrollView{
    
    //不要自动调整scrollVeiw内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    scrollV.backgroundColor = [UIColor whiteColor];
    self.scrollView = scrollV;
    
    
    scrollV.scrollsToTop = NO;
    scrollV.delegate = self;//设置控制器为scrollView的代理
    scrollV.pagingEnabled = YES;//设置分页效果
    scrollV.bounces = NO;//取消scrollView弹簧效果
    scrollV.frame = self.view.bounds;
    [self.view addSubview:scrollV];
    
    //设置scrollView内容大小
    scrollV.contentSize = CGSizeMake(self.childViewControllers.count * scrollV.width, 0);
}

#pragma mark - 设置导航栏内容
-(void)setUpNavgationItem{
    //设置title
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //leftButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] targer:self action:@selector(game)];
    
    //rightButton
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] targer:self action:nil];

}

#pragma mark - 监听标题栏按钮点击
-(void)titleButtonClick:(FJTitleButton *)titleButton{
    //如果重复点击标题按钮,发出通知
    if (self.selectedButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FJTitleButtonDidRepeatClickedNotification" object:nil];
    }
    
    //按钮被点击时要执行的操作
    [self dealTitleButtonClick:titleButton];
    
}

-(void)dealTitleButtonClick:(FJTitleButton *)titleButton{
    
    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;
    
     NSInteger index = titleButton.tag;
    
    [UIView animateWithDuration:0.25 animations:^{
        //下划线
        self.titleButtonUnderLineView.width = titleButton.titleLabel.width + FJMargin;
        self.titleButtonUnderLineView.centerX = titleButton.centerX;
        
        //滚动ScrollView
        self.scrollView.contentOffset = CGPointMake(index *self.scrollView.width, 0);
        
    } completion:^(BOOL finished) {
        [self addChildViewControllerIntoScrollView:index];
    }];
    
    //处理tableview的滚动(显示在屏幕外面的view不需要滚动到最前面)
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
//        UIView *childVcView = self.childViewControllers[i].view;
        UIViewController *childVC = self.childViewControllers[i];
        //如果控制器的view 没有创建,直接返回
        if (![childVC isViewLoaded]) continue;
        UIView *childVcView = childVC.view;
        
        if ([childVcView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)childVcView;
            scrollView.scrollsToTop = (i == index);
            
        }
    }
}

#pragma mark - UIScrollViewDelegate_监听scrollView滚动
//结束滚动时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    

    //点击对应的按钮
    //1.1求出按钮对应的tag
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //1.2取出标题栏按钮控件
    FJTitleButton *titleBtn = self.titleView.subviews[index];
    //2.按钮触发点击事件
    [self dealTitleButtonClick:titleBtn];
}

#pragma mark - 添加scrollView的子控制器
-(void)addChildViewControllerIntoScrollView:(NSInteger)index{
    
    UIViewController *childVC = self.childViewControllers[index];
    [self.scrollView addSubview:childVC.view];
    
    //设置位置和尺寸
    childVC.view.frame = self.scrollView.bounds;

}

-(void)game{
    
    NSLog(@"game");
}



@end
