//
//  FJADViewController.m
//  BuDeJie
//
//  Created by Francis on 16/2/19.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJADViewController.h"
#import <AFNetworking.h>
#import "FJADItem.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "FJTabBarController.h"


#define FJCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface FJADViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageV;
/** 广告*/
@property (nonatomic ,strong) FJADItem *adItem;
/** 广告view*/
@property (nonatomic ,weak) UIImageView *adView;
/** 跳过按钮*/
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
/** 定时器*/
@property (nonatomic ,weak) NSTimer *timer;

@end

@implementation FJADViewController

#pragma mark - lazy
-(UIImageView *)adView{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.view insertSubview:imageView aboveSubview:self.backGroundImageV];
        _adView = imageView;
    }
    return _adView;
}
//跳过按钮点击
- (IBAction)jump:(id)sender {
    
    [_timer invalidate];
    
    FJTabBarController *tabBatC = [[FJTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBatC;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpBackground];
    
    //加载广告网络请求
    //创建会话管理者
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"code2"] = FJCode2;
    
    //发送get请求
    [sessionManager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        
//        [responseObject writeToFile:@"/Users/francis/Documents/Developer/800-实用技术/百思不得姐/02.广告处理/11.加载广告界面数据/BuDeJie/ad.plist" atomically:YES];
        
        NSDictionary *dict = [responseObject[@"ad"] lastObject];
        
        _adItem = [FJADItem mj_objectWithKeyValues:dict];
        
        //设置广告view的尺寸
        CGFloat h = FJScreenW / _adItem.w * _adItem.h;
        self.adView.frame = CGRectMake(0, 0, FJScreenW, h);
        
        //加载广告的view
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_adItem.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    //通过定时器控制广告时间
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];
    
}

-(void)timeChange:(id)timer{
    static int i = 3;
//    NSLog(@"%@",[NSThread currentThread]);
    NSString *str = [NSString stringWithFormat:@"跳过 (%d)",i];
    [_jumpButton setTitle:str forState:UIControlStateNormal];
    
    if (i < 0) {
        
        [self jump:nil];
    }
    
    i--;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_adItem.ori_curl]];

}
-(void)setUpBackground{
    if (iPhone6P) {
        _backGroundImageV.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iPhone6){
        _backGroundImageV.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (iPhone5){
        _backGroundImageV.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    }else if (iPhone4){
        _backGroundImageV.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
}

@end
