//
//  PhoneLoginViewController.m
//  CutHand
//
//  Created by hztuen on 2017/5/9.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "PhoneLoginViewController.h"
#import "LoginButton.h"

#define time60 60

@interface PhoneLoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *phoneNumView;
@property (nonatomic, strong) UIImageView *phoneImage;
@property (nonatomic, strong) UITextField *phoneNumTextField;
@property (nonatomic, strong) UIView *checkCodeView;
@property (nonatomic, strong) UIImageView *checkCodeImage;
@property (nonatomic, strong) UITextField *checkCodeTextField;
@property (nonatomic, strong) UIButton *checkCodeBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) LoginButton *loginBtn;
@property (nonatomic, strong) NSTimer *timer;//倒计时
@property (nonatomic, assign) int second;//秒数

@end

@implementation PhoneLoginViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self buildUI];
}

- (void)initData {
    self.title = @"手机号登录";
    self.view.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
}

- (void)buildUI {
    //导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:MainColor alpha:1.0]];
    // UINavigationBar 设置字体
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{ NSForegroundColorAttributeName: [UIColor colorWithHexString:@"ffffff" alpha:1.0], NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    //手机号view
    self.phoneNumView = [[UIView alloc] init];
    self.phoneNumView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    [self.view addSubview:self.phoneNumView];
    [self.phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset([self Suit:76]);
        make.width.mas_equalTo([self Suit:520/2]);
        make.height.mas_equalTo([self Suit:40]);
    }];
    
    //手机image
    self.phoneImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phoneNum_gray"]];
    [self.phoneNumView addSubview:self.phoneImage];
    [self.phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.phoneNumView.mas_centerY);
        make.left.equalTo(self.phoneNumView.mas_left);
    }];
    
    UIView *phoneLine = [[UIView alloc] init];
    phoneLine.backgroundColor = [UIColor colorWithHexString:@"979797" alpha:1.0];
    [self.phoneNumView addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.phoneNumView.mas_bottom);
        make.left.equalTo(self.phoneImage.mas_right).offset([self Suit:15]);
        make.right.equalTo(self.phoneNumView.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    //手机输入textField
    self.phoneNumTextField = [[UITextField alloc] init];
    self.phoneNumTextField.delegate = self;
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTextField.textColor = [UIColor colorWithHexString:@"7F7F7F" alpha:1.0];
    self.phoneNumTextField.font = [UIFont systemFontOfSize:14];
    self.phoneNumTextField.placeholder = @"在此输入您的手机号";
    [self.phoneNumTextField setValue:[UIColor colorWithHexString:@"C0C0C0" alpha:1.0]forKeyPath:@"_placeholderLabel.textColor"];
    self.phoneNumTextField.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    [self.phoneNumTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneNumView addSubview:self.phoneNumTextField];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumView.mas_top);
        make.left.equalTo(self.phoneImage.mas_right).offset([self Suit:15]);
        make.bottom.equalTo(phoneLine.mas_top);
        make.right.equalTo(self.phoneNumView.mas_right);
    }];
    
    //验证码view
    self.checkCodeView = [[UIView alloc] init];
    self.checkCodeView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    [self.view addSubview:self.checkCodeView];
    [self.checkCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset([self Suit:158]);
        make.width.mas_equalTo([self Suit:520/2]);
        make.height.mas_equalTo([self Suit:40]);
    }];
    
    //验证码image
    self.checkCodeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkCode_gray"]];
    [self.checkCodeView addSubview:self.checkCodeImage];
    [self.checkCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.checkCodeView.mas_centerY);
        make.left.equalTo(self.checkCodeView.mas_left);
    }];
    
    UIView *checkCodeLine = [[UIView alloc] init];
    checkCodeLine.backgroundColor = [UIColor colorWithHexString:@"979797" alpha:1.0];
    [self.checkCodeView addSubview:checkCodeLine];
    [checkCodeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.checkCodeView.mas_bottom);
        make.left.equalTo(self.checkCodeImage.mas_right).offset([self Suit:15]);
        make.right.equalTo(self.checkCodeView.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    //验证码textField
    self.checkCodeTextField = [[UITextField alloc] init];
    self.checkCodeTextField.delegate = self;
    self.checkCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.checkCodeTextField.textColor = [UIColor colorWithHexString:@"7F7F7F" alpha:1.0];
    self.checkCodeTextField.font = [UIFont systemFontOfSize:14];
    self.checkCodeTextField.placeholder = @"输入验证码";
    [self.checkCodeTextField setValue:[UIColor colorWithHexString:@"C0C0C0" alpha:1.0]forKeyPath:@"_placeholderLabel.textColor"];
    self.checkCodeTextField.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    [self.checkCodeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.checkCodeView addSubview:self.checkCodeTextField];
    [self.checkCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.checkCodeView.mas_top);
        make.left.equalTo(self.checkCodeImage.mas_right).offset([self Suit:15]);
        make.bottom.equalTo(checkCodeLine.mas_top);
        make.right.equalTo(self.checkCodeView.mas_right).offset([self Suit:-125/2]);
    }];
    
    //获取验证码
    self.checkCodeBtn = [UIButton buttonWithTitle:@"获取验证码" AndTitleColor:@"ffffff" AndTitleFont:[self SuitFont:10] AndBackgroundColor:MainColor addTarget:self action:@selector(clickCheckCodeBtn)];
    [self.checkCodeView addSubview:self.checkCodeBtn];
    [self.checkCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.checkCodeView.mas_centerY);
        make.right.equalTo(self.checkCodeView.mas_right);
        make.height.mas_equalTo([self Suit:25]);
        make.width.mas_equalTo([self Suit:125/2]);
    }];
    
    //倒计时
    self.timeLabel = [UILabel labelWithColor:@"ffffff" AndFont:[self SuitFont:10] AndAlignment:NSTextAlignmentCenter];
    self.timeLabel.backgroundColor = [UIColor colorWithHexString:@"C0C0C0" alpha:1.0];
    self.timeLabel.hidden = YES;
    [self.checkCodeBtn addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.checkCodeBtn.mas_top);
        make.bottom.equalTo(self.checkCodeBtn.mas_bottom);
        make.left.equalTo(self.checkCodeBtn.mas_left);
        make.right.equalTo(self.checkCodeBtn.mas_right);
    }];
    
    //登录按钮
    self.loginBtn = [[LoginButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-[self Suit:605/4], [self Suit:280], [self Suit:605/2], [self Suit:48])];
    self.loginBtn.userInteractionEnabled = NO;
    self.loginBtn.contentColor = [UIColor colorWithHexString:@"c0c0c0" alpha:1.0];
    self.loginBtn.progressColor = [UIColor whiteColor];
    self.loginBtn.layer.cornerRadius = [self Suit:24];
    self.loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.loginBtn];
    
    [self.loginBtn.forDisplayButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn.forDisplayButton.titleLabel setFont:[UIFont systemFontOfSize:[self SuitFont:20]]];
    [self.loginBtn.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.forDisplayButton.backgroundColor = [UIColor colorWithHexString:@"c0c0c0" alpha:1.0];
    [self.loginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //协议
    UILabel *protocolLabel = [UILabel labelWithTitle:@"登录即代表你同意" AndColor:@"606060" AndFont:[self SuitFont:11] AndAlignment:NSTextAlignmentCenter];
    [self.view addSubview:protocolLabel];
    [protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset([self Suit:10]);
        make.left.equalTo(self.loginBtn.mas_left);
    }];
    
    UIButton *protocolBtn = [UIButton buttonWithTitle:@"《狗粮服务和隐私条款》" AndTitleColor:MainColor AndTitleFont:[self SuitFont:11] AndBackgroundColor:nil addTarget:self action:@selector(clickProtocolBtn)];
    [self.view addSubview:protocolBtn];
    [protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(protocolLabel.mas_centerY);
        make.left.equalTo(protocolLabel.mas_right);
    }];
    
}

#pragma mark - Actions

- (void)textFieldDidChange:(UITextField *)textField {
    //左侧图标变颜色
    if (textField == self.phoneNumTextField) {
        if (self.phoneNumTextField.text.length == 11) {
            self.phoneImage.image = [UIImage imageNamed:@"phoneNum_red"];
        } else {
            self.phoneImage.image = [UIImage imageNamed:@"phoneNum_gray"];
        }
    } else {
        if (self.checkCodeTextField.text.length == 6) {
            self.checkCodeImage.image = [UIImage imageNamed:@"checkCode_red"];
        } else {
            self.checkCodeImage.image = [UIImage imageNamed:@"checkCode_gray"];
        }
    }
    
    //登录按钮变颜色
    if (self.phoneNumTextField.text.length == 11 && self.checkCodeTextField.text.length == 6) {
        self.loginBtn.contentColor = [UIColor colorWithHexString:MainColor alpha:1.0];
        self.loginBtn.forDisplayButton.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0];
        self.loginBtn.userInteractionEnabled = YES;
    } else {
        self.loginBtn.contentColor = [UIColor colorWithHexString:@"C0C0C0" alpha:1.0];
        self.loginBtn.forDisplayButton.backgroundColor = [UIColor colorWithHexString:@"C0C0C0" alpha:1.0];
    }
}

- (void)clickLoginBtn {
    [self.loginBtn startAnimation];
    self.loginBtn.userInteractionEnabled = NO;
    [self performSelector:@selector(stop) withObject:self afterDelay:3];
}

- (void)stop {
    [self.loginBtn stopAnimation];
    self.loginBtn.userInteractionEnabled = YES;
}

- (void)clickCheckCodeBtn {
    [self decreaseTime];
}

-(void)decreaseTime
{
    [self.checkCodeBtn setTitle:@"" forState:UIControlStateNormal];
    self.checkCodeBtn.enabled = NO;
    self.second = time60;
    self.timeLabel.hidden = NO;
    self.timeLabel.text = [NSString stringWithFormat:@"%is",self.second];
    
    if(self.timer == nil) {
        [self initTimer];
    } else {
        [self startTimer];
    }
}

- (void)clickProtocolBtn {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//若为空初始化计时器
- (void)initTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}

- (void)countDown:(NSTimer *)timer {
    if(self.second > 0) {
        self.second--;
        self.timeLabel.text= [NSString stringWithFormat:@"%is",self.second];
    } else {
        [self stopTimer];
        self.timeLabel.hidden=YES;
        [self.checkCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.checkCodeBtn.enabled=YES;
    }

}

//开启计时器
- (void)startTimer {
    [self.timer setFireDate:[NSDate distantPast]];
}

//暂停计时器
- (void)stopTimer {
    [self.timer setFireDate:[NSDate distantFuture]];
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
