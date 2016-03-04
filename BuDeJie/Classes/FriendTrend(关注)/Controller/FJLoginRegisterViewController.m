//
//  FJLoginRegisterViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/20.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJLoginRegisterViewController.h"
#import "FJLoginRegisterView.h"
#import "FJFastLoginView.h"
#import "FJLoginRegisterField.h"
#import "UITextField+Placeholder.h"

@interface FJLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;

@property (weak, nonatomic) IBOutlet UIView *bottomVeiw;

@property (weak, nonatomic) IBOutlet FJLoginRegisterField *textF;


@end

@implementation FJLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建注册和登录界面
    FJLoginRegisterView *loginV = [FJLoginRegisterView loginView];
    loginV.width = self.inputView.width * 0.5;
    [self.inputView addSubview:loginV];
    
    FJLoginRegisterView *registerV = [FJLoginRegisterView registerView];
    registerV.width = self.inputView.width * 0.5;
    registerV.x = self.inputView.width * 0.5;
    [self.inputView addSubview:registerV];
    
    //加载快速登陆view
    FJFastLoginView *fastLoginV = [FJFastLoginView fastLoginView];
    [self.bottomVeiw addSubview:fastLoginV];
    
    self.textF.placeholderColor = [UIColor redColor];
    self.textF.placeholder = @"qwert";
    
   
}



//关闭按钮点击
- (IBAction)closeButtonClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//注册按钮点击
- (IBAction)registerButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
//    NSLog(@"registerButtonClick-----");
    
    _leadCons.constant = _leadCons.constant == 0?-FJScreenW:0;
//    _leadCons.constant = -FJScreenW;

    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//
//    
//    CGFloat x = 0;
//    CGFloat y = 0;
//    CGFloat w = self.inputView.width * 0.5 ;
//    CGFloat h = self.inputView.height;
//    
//    for (int i = 0; i < self.inputView.subviews.count; i++) {
//        UIView *v = self.inputView.subviews[i];
//        x = i * w;
//        v.frame = CGRectMake(x, y, w, h);
//    }
    

    
    //设置快速登陆view的frame
    [[self.bottomVeiw.subviews lastObject] setFrame:self.bottomVeiw.bounds];
}

@end
