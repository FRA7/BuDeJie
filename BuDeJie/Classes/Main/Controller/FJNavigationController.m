//
//  FJNavigationController.m
//  BuDeJie
//
//  Created by Francis on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJNavigationController.h"

@interface FJNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation FJNavigationController

+(void)load{
    //获取当前类下所有navigationBar Item
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    //设置导航栏标题
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    
    [navBar setTitleTextAttributes:attr];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        button.backgroundColor = [UIColor redColor];
        [button sizeToFit];
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //设置内容边距
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    [super pushViewController:viewController animated:YES];
}

-(void)back{
    [self popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    //防止根控制器触发手势导致假死
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}

@end
