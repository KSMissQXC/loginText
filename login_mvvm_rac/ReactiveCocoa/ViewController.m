//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by xiaomage on 15/10/25.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"

#import "GlobeHeader.h"
#import "AFNetworking.h"
#import "MBProgressHUD+XMG.h"
#import "LoginViewModel.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic)LoginViewModel *loginModel;






@end

@implementation ViewController
#pragma mark - 懒加载
-(LoginViewModel *)loginModel{
    if (_loginModel == nil) {
        _loginModel = [[LoginViewModel alloc]init];
    }
    return _loginModel;
}



#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
    
    [self loginEvent];
    
    
    

}

-(void)bindViewModel{
    
    //给视图模型的账号和密码绑定信号
    RAC(self.loginModel,account) = self.accountTextField.rac_textSignal;
    
    RAC(self.loginModel,pwd) = self.pwdTextField.rac_textSignal;

    
}

-(void)loginEvent{
    RAC(_loginBtn,enabled) = self.loginModel.loginEnableSignal;

    //监听按钮的点击事件
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"点击了登录按钮----");
        
        
        //执行命令
        [self.loginModel.loginCom execute:@"go"];
        
    }];

    
}


@end
