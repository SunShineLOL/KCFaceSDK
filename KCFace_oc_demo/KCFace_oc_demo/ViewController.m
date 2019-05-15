//
//  ViewController.m
//  KCFace_oc_demo
//
//  Created by czn on 2019/5/15.
//  Copyright © 2019 czn. All rights reserved.
//

#import "ViewController.h"
#import <KCFace/KCFace.h>

@interface ViewController ()<KCSDKDelegate>
    
    @end

@implementation ViewController
    
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //view.snp
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"启动SDK" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGRect frame = self.view.frame;
    btn.frame = CGRectMake(CGRectGetMidX(frame) - 50, CGRectGetMidY(frame) - 20, 100, 40);
    [self.view addSubview:btn];
    
}
- (void)btnAction{
    
    KCSDKManager *manager = [KCSDKManager sharedInstances];
    manager.delegate = self;
    [manager configSDK:@"kechong" :@"2d08d3c1b7c14468ab14bf8aca454070" :@"" :@"" :@"kc" :@"kechong"];
    [manager showKCFace:self complete:^(BOOL isSuss, NSString * _Nonnull desc) {
        if (isSuss) {
            NSLog(@"成功:%@",desc);
        }else{
            NSLog(@"失败:%@",desc);
        }
    }];
}
- (void)kcAccreditWXPay{
    NSLog(@"去开通");
}
    @end
