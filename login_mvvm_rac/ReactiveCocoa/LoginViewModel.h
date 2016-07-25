//
//  LoginViewModel.h
//  ReactiveCocoa
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobeHeader.h"


@interface LoginViewModel : NSObject


//保存账号和密码
@property (copy, nonatomic)NSString *account;
@property (copy, nonatomic)NSString *pwd;

//登录是否可用的聚合信号
@property (strong, nonatomic)RACSignal *loginEnableSignal;

//发送登录的请求命令
@property (strong, nonatomic)RACCommand *loginCom;








@end
