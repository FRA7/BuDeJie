//
//  AppDelegate.m
//  BuDeJie
//
//  Created by Francis on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "AppDelegate.h"
#import "FJTabBarController.h"
#import "FJADViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

//监听当前状态栏的点击事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:nil];
    if (point.y > 20) return;
        
}

static UIWindow *topWindow_;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置窗口根控制器
    FJTabBarController *tabBarVC = [[FJTabBarController alloc] init];
//    FJADViewController *tabBarVC = [[FJADViewController alloc] init];
    self.window.rootViewController = tabBarVC;
    
    //3.加载窗口
    [self.window makeKeyAndVisible];
    
//    //4.加载顶层window
//    [self showTopWindow];
    
    return YES;
}

//-(void)showTopWindow{
//    
//    //延迟一段时间创建,否则和根控制器同时创建会报错
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        topWindow_ = [[UIWindow alloc] init];
//        topWindow_.backgroundColor = [UIColor redColor];
//        //设置window级别
//        topWindow_.windowLevel = UIWindowLevelAlert;
//        topWindow_.frame = [UIApplication sharedApplication].statusBarFrame;
//        topWindow_.hidden = NO;
//        
//        //添加手势
//        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)];
//        [topWindow_ addGestureRecognizer:tapGest];
//        
//    });
//    
//}
//
//-(void)topWindowClick{
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [self searchAllScrollViewInView:window];
//}
//
//-(void)searchAllScrollViewInView:(UIView *)view{
//    
//    //递归遍历所有子控件
//    for (UIView *subView in view.subviews) {
//        [self searchAllScrollViewInView:subView];
//    }
//    
//    //如果不是scrollView直接返回
//    if (![view isKindOfClass:[UIScrollView class]]) return;
//    
//    //回滚到最前面
//    UIScrollView *scrollView = (UIScrollView *)view;
//    
//    CGPoint offset = scrollView.contentOffset;
//    offset.y = - scrollView.contentInset.top;
//    [scrollView setContentOffset:offset animated:YES];
//    
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
