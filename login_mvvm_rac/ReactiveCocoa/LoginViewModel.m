//
//  LoginViewModel.m
//  ReactiveCocoa
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "LoginViewModel.h"
#import "MBProgressHUD+XMG.h"


@implementation LoginViewModel
//重写init方法
-(instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
    
}


//做初始化操作
-(void)setup{
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, pwd)] reduce:^id(NSString *account,NSString *pwd){
        return @(account.length && pwd.length);
    }];

    _loginCom = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block:执行命令就会调用
        // block作用:事件处理
        // 发送登录请求
        NSLog(@"发送登录请求%@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //发送数据
                [subscriber sendNext:@"请求完成的数据"];
                
                //请求完成
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    //订阅请求的命令
    [_loginCom.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"---收到订阅的信号%@",x);
    }];
    
    //监听命令的过程
    [[_loginCom.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            NSLog(@"正在执行");
            // 显示蒙版
            [MBProgressHUD showMessage:@"正在登录ing.."];
        }else{
            // 执行完成
            // 隐藏蒙版
            [MBProgressHUD hideHUD];
            NSLog(@"执行完成");
            
        }
        
    }];

    
    
}


@end
