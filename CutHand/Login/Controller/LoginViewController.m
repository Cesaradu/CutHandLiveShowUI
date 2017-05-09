//
//  LoginViewController.m
//  CutHand
//
//  Created by hztuen on 2017/4/28.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface LoginViewController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UIButton *wechatBtn;
@property (nonatomic, strong) UIButton *phoneBtn;
@property (nonatomic, strong) UILabel *loginLabel;
@property (nonatomic, strong) UILabel *slogen;


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
    
    //背景图
//    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg"]];
//    bgImage.frame = self.view.frame;
//    [self.view addSubview:bgImage];
    
    //视频播放
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"cutHand" ofType:@"mp4"];
    self.moviePlayerController.contentURL = [[NSURL alloc] initFileURLWithPath:moviePath];
    [self.moviePlayerController play];
    [self.moviePlayerController.view bringSubviewToFront:self.view];
    
    
    self.logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    self.logoImage.alpha = 0.f;
    [self.view addSubview:self.logoImage];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset([self Suit:220/2]);
        make.width.height.mas_equalTo([self Suit:227/2]);
    }];
    
    self.wechatBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-[self Suit:95], ScreenHeight-[self Suit:65], [self Suit:65], [self Suit:65])];
    self.wechatBtn.alpha = 0.f;
    [self.wechatBtn setImage:[UIImage imageNamed:@"wechat_login"] forState:UIControlStateNormal];
    [self.wechatBtn addTarget:self action:@selector(clickWechatBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wechatBtn];
    
    self.phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2+[self Suit:30], ScreenHeight-[self Suit:65], [self Suit:65], [self Suit:65])];
    self.phoneBtn.alpha = 0.f;
    [self.phoneBtn setImage:[UIImage imageNamed:@"phone_login"] forState:UIControlStateNormal];
    [self.phoneBtn addTarget:self action:@selector(clickPhoneBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.phoneBtn];
    
    self.loginLabel = [UILabel labelWithTitle:@"使用以下方式登录" AndColor:@"ffffff" AndFont:[self SuitFont:14] AndAlignment:NSTextAlignmentCenter];
    self.loginLabel.alpha = 0.f;
    [self.view addSubview:self.loginLabel];
    [self.loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset([self Suit:-185]);
    }];
    
    self.slogen = [UILabel labelWithTitle:@"这是一条slogen" AndColor:@"ffffff" AndFont:[self SuitFont:30] AndAlignment:NSTextAlignmentCenter];
    self.slogen.alpha = 0.f;
    [self.view addSubview:self.slogen];
    [self.slogen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.logoImage.mas_bottom).offset([self Suit:20]);
    }];
    
    [self performSelector:@selector(startAnimation) withObject:self afterDelay:0.5];
}

- (void)startAnimation {
    [UIView animateWithDuration:1.5 animations:^{
        self.logoImage.alpha = 1.0;
        self.slogen.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:0. usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.loginLabel.alpha = 1.0;
            self.wechatBtn.alpha = 1.0;
            self.phoneBtn.alpha = 1.0;
            self.wechatBtn.frame = CGRectMake(ScreenWidth/2-[self Suit:95], ScreenHeight-[self Suit:165], [self Suit:65], [self Suit:65]);
            self.phoneBtn.frame = CGRectMake(ScreenWidth/2+[self Suit:30], ScreenHeight-[self Suit:165], [self Suit:65], [self Suit:65]);
        } completion:nil];
    }];
}

#pragma mark - NSNotificationCenter
- (void)playbackStateChanged
{
    MPMoviePlaybackState playbackState = [self.moviePlayerController playbackState];
    if (playbackState == MPMoviePlaybackStateStopped || playbackState == MPMoviePlaybackStatePaused) {
        [self.moviePlayerController play];
    }
}

#pragma mark - setter and getter
- (MPMoviePlayerController *)moviePlayerController {
    if (!_moviePlayerController) {
        _moviePlayerController = [[MPMoviePlayerController alloc] init];
        _moviePlayerController.movieSourceType = MPMovieSourceTypeFile;
        _moviePlayerController.controlStyle = MPMovieControlStyleNone;
        _moviePlayerController.view.frame = [UIScreen mainScreen].bounds;
        [_moviePlayerController setFullscreen:YES];
        [_moviePlayerController setShouldAutoplay:YES];
        [_moviePlayerController setRepeatMode:MPMovieRepeatModeOne];
        [self.view addSubview:self.moviePlayerController.view];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
    }
    return _moviePlayerController;
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
