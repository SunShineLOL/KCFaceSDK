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
    CGRect frame = self.view.frame;
    
    UIButton *btn = [self createBtn:@"启动SDK"];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(CGRectGetMidX(frame) - 100, CGRectGetMidY(frame) - 20 - 60, 200, 40);
    [self.view addSubview:btn];
    
    UIButton *btn2 = [self createBtn:@"获取平台消费记录"];
    [btn2 addTarget:self action:@selector(btnAction2) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(CGRectGetMidX(frame) - 100, CGRectGetMidY(frame) - 20, 200, 40);
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [self createBtn:@"更新免密签名"];
    [btn3 addTarget:self action:@selector(btnAction3) forControlEvents:UIControlEventTouchUpInside];
    btn3.frame = CGRectMake(CGRectGetMidX(frame) - 100, CGRectGetMidY(frame) - 20 + 60, 200, 40);
    [self.view addSubview:btn3];
    
}
- (UIButton *)createBtn:(NSString *) title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return btn;
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
- (void)btnAction2{
    
    KCSDKManager *manager = [KCSDKManager sharedInstances];
    [manager configSDK:@"kechong" :@"2d08d3c1b7c14468ab14bf8aca454070" :@"" :@"" :@"kc" :@"kechong"];
    [manager payRecords:0 :0 complete:^(BOOL isSuss, NSDictionary<NSString *,id> * _Nullable dict) {
        if (isSuss) {
            NSLog(@"成功:%@",dict);
        }else{
            NSLog(@"失败:%@",dict);
        }
    }];
}
- (void)btnAction3{
    
    KCSDKManager *manager = [KCSDKManager sharedInstances];
    manager.delegate = self;
    [manager configSDK:@"kechong" :@"2d08d3c1b7c14468ab14bf8aca454070" :@"" :@"" :@"kc" :@"kechong"];
    [manager updateContractId:@"xxxxxx" complete:^(BOOL isSuss) {
        if (isSuss) {
            NSLog(@"成功");
        }else{
            NSLog(@"失败");
        }
    }];
    
}
- (void)kcAccreditWXPay{
    NSLog(@"去开通");
}
    @end
