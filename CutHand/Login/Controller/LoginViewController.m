//
//  LoginViewController.m
//  CutHand
//
//  Created by hztuen on 2017/4/28.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
    [self buildUI];
}

- (void)setupInit {
    
}

- (void)buildUI {
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg"]];
    bgImage.frame = self.view.frame;
    [self.view addSubview:bgImage];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset([self Suit:220/2]);
        make.width.height.mas_equalTo([self Suit:227/2]);
    }];
    
    UIButton *wechatBtn = [[UIButton alloc] init];
    [wechatBtn setImage:[UIImage imageNamed:@"wechat_login"] forState:UIControlStateNormal];
    [wechatBtn addTarget:self action:@selector(clickWechatBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatBtn];
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset([self Suit:-100]);
        make.right.equalTo(self.view.mas_centerX).offset([self Suit:-30]);
    }];
    
    UIButton *phoneBtn = [[UIButton alloc] init];
    [phoneBtn setImage:[UIImage imageNamed:@"phone_login"] forState:UIControlStateNormal];
    [phoneBtn addTarget:self action:@selector(clickPhoneBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneBtn];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset([self Suit:-100]);
        make.left.equalTo(self.view.mas_centerX).offset([self Suit:30]);
    }];
    
    UILabel *loginLabel = [UILabel labelWithTitle:@"使用以下方式登录" AndColor:@"ffffff" AndFont:[self SuitFont:14] AndAlignment:NSTextAlignmentCenter];
    [self.view addSubview:loginLabel];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(wechatBtn.mas_top).offset([self Suit:-20]);
    }];
    
    UILabel *slogen = [UILabel labelWithTitle:@"这是一条slogen" AndColor:@"ffffff" AndFont:[self SuitFont:30] AndAlignment:NSTextAlignmentCenter];
    [self.view addSubview:slogen];
    [slogen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(logoImage.mas_bottom).offset([self Suit:20]);
    }];
    
}

- (void)clickWechatBtn {
    MainTabBarController *mainVC = [[MainTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}

- (void)clickPhoneBtn {
    MainTabBarController *mainVC = [[MainTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
