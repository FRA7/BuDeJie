//
//  FJNewViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/18.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJNewViewController.h"
#import "FJSubTagViewController.h"

@interface FJNewViewController ()

@end

@implementation FJNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self setUpNavgationItem];
}
-(void)setUpNavgationItem{
    //设置title
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //leftButton-关注按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] targer:self action:@selector(tagButtonClick)];
}

-(void)tagButtonClick{
    FJSubTagViewController *tagVC = [[FJSubTagViewController alloc] init];
    tagVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tagVC animated:YES];
}
@end
