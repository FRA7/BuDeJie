//
//  FJTabBarController.m
//  BuDeJie
//
//  Created by Francis on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJTabBarController.h"
#import "FJEssenceViewController.h"
#import "FJFriendTrendViewController.h"
#import "FJMeViewController.h"
#import "FJNewViewController.h"
#import "FJPublishViewController.h"
#import "FJTabBar.h"

#import "FJNavigationController.h"

@interface FJTabBarController ()

@end

@implementation FJTabBarController

//只会调用一次,类加载的时候就调用
+(void)load{
    
   //1.获取当前类下的所有tabbar
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrSel = [NSMutableDictionary dictionary];
    attrSel[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrSel forState:UIControlStateSelected];
    
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    attrNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrNor forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置子控制器
    [self setUpChildViewController];
    //设置tabbar按钮
    [self setUpTabBarButton];
    
    FJTabBar *tabBar = [[FJTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

-(void)setUpTabBarButton{
    
    //精华
    UINavigationController *nav1 = self.childViewControllers[0];
    nav1.tabBarItem.title = @"精华";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageNameWithOriginalMode:@"tabBar_essence_click_icon"];
    
    //新帖
    UINavigationController *nav2 = self.childViewControllers[1];
    nav2.tabBarItem.title = @"新帖";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageNameWithOriginalMode:@"tabBar_new_click_icon"];
    
    //关注
    UINavigationController *nav4 = self.childViewControllers[2];
    nav4.tabBarItem.title = @"关注";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageNameWithOriginalMode:@"tabBar_friendTrends_click_icon"];
    
    //我
    UINavigationController *nav5 = self.childViewControllers[3];
    nav5.tabBarItem.title = @"我";
    nav5.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav5.tabBarItem.selectedImage = [UIImage imageNameWithOriginalMode:@"tabBar_me_click_icon"];
}

-(void)setUpChildViewController{
    
    
    //精华
    FJEssenceViewController *essenceVC = [[FJEssenceViewController alloc] init];
    [self addChildViewController:essenceVC];
    
    //新帖
    FJNewViewController *newVC = [[FJNewViewController alloc] init];
    [self addChildViewController:newVC];
    
    
    //关注
    FJFriendTrendViewController *friendTrendVC = [[FJFriendTrendViewController alloc] init];
    [self addChildViewController:friendTrendVC];
    
    //我
    UIStoryboard *meStoryBoard = [UIStoryboard storyboardWithName:@"FJMeViewController" bundle:nil];
    
    FJMeViewController *meVC = [meStoryBoard instantiateInitialViewController];
    [self addChildViewController:meVC];
    
    
}

- (void)addChildViewController:(UIViewController *)childController{
    FJNavigationController *nav = [[FJNavigationController alloc] initWithRootViewController:childController];
    [super addChildViewController:nav];
}
@end
