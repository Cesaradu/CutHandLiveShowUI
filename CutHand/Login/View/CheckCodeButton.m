//
//  CheckCodeButton.m
//  CutHand
//
//  Created by hztuen on 2017/5/11.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "CheckCodeButton.h"


@interface CheckCodeButton ()

@property (nonatomic, strong) NSTimer *timer;//倒计时

@end

@implementation CheckCodeButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSetting];
    }
    return self;
}

- (void)initSetting {
    
    //获取验证码按钮
    self.backgroundColor = [UIColor grayColor];
    [self setTitle:@"获取验证码" forState: UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //倒计时label
    self.timeLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.timeLabel.backgroundColor = [UIColor colorWithHexString:@"c0c0c0" alpha:1.0];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.hidden = YES;
    [self addSubview:self.timeLabel];
    
}

- (void)setSecond:(int)second {
    _second = second;
}

// 点击获取验证码开始倒计时
- (void)startDecreaseTime {
    [self setTitle:@"" forState:UIControlStateNormal];
    self.enabled = NO;
    self.timeLabel.hidden = NO;
    self.timeLabel.text = [NSString stringWithFormat:@"%is",self.second];
    
    if(self.timer == nil) {
        [self initTimer];
    } else {
        self.second = self.second + 1;
        [self startTimer];
    }
}

//若为空初始化计时器
- (void)initTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}

- (void)countDown: (NSTimer *)timer {
    if(self.second > 0) {
        self.second--;
        self.timeLabel.text = [NSString stringWithFormat:@"%is",self.second];
    } else {
        [self destroyTimer];
        self.timeLabel.hidden = YES;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.enabled = YES;
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

//销毁计时器
- (void)destroyTimer {
    [self.timer invalidate];
    self.timer = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
