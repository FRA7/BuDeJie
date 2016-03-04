//
//  FJFriendTrendViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJFriendTrendViewController.h"
#import "FJLoginRegisterViewController.h"


@interface FJFriendTrendViewController ()

@end

@implementation FJFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self setUpNavgationItem];
}
- (IBAction)liginOrRegister:(id)sender {
    
    NSLog(@"登陆注册按钮点击");
    
    FJLoginRegisterViewController *loginVC = [[FJLoginRegisterViewController alloc] init];
    
    [self presentViewController:loginVC animated:YES completion:nil];
}

-(void)setUpNavgationItem{
    //设置title
    self.navigationItem.title = @"我的关注";
    //leftButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] targer:self action:nil];
    
    
}
@end
