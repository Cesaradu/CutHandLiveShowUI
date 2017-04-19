//
//  AnimationButton.m
//  CutHand
//
//  Created by hztuen on 2017/4/19.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "AnimationButton.h"

@implementation AnimationButton
{
    CGFloat defaultW; //宽
    CGFloat defaultH; //高
    CGFloat defaultR; //圆角
    CGFloat scale; //拉伸比例
    UIView *bgView; //背景
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSetting];
    }
    return self;
}

- (CGRect)frame {
    CGRect frame = [super frame];
    self.displayButton.frame = frame;
    return frame;
}

- (void)initSetting {
    scale = 1.2;
    bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor blueColor];
    bgView.userInteractionEnabled = NO;
    bgView.hidden = YES;
    [self addSubview:bgView];
    
    defaultW = bgView.frame.size.width;
    defaultH = bgView.frame.size.height;
    defaultR = bgView.layer.cornerRadius;
    
    //弹性视图
    MMMaterialDesignSpinner *spinnerView = [[MMMaterialDesignSpinner alloc] initWithFrame:CGRectZero];
    self.spinnerView = spinnerView;
    self.spinnerView.bounds = CGRectMake(0, 0, defaultH*0.8, defaultH*0.8);
    self.spinnerView.tintColor = [UIColor whiteColor];
    self.spinnerView.lineWidth = 2;
    self.spinnerView.center = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
    self.spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.spinnerView.userInteractionEnabled = NO;
    [self addSubview:self.spinnerView];
    
    [self initBtn];
}

- (void)initBtn {
    self.displayButton = [[UIButton alloc]initWithFrame:self.bounds];
    self.displayButton.userInteractionEnabled = NO;
    [self addSubview:self.displayButton];
}

- (void)startAnimation {
    self.isLoading = YES;
    bgView.hidden = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:defaultR];
    animation.toValue = [NSNumber numberWithFloat:defaultH*scale*0.5];
    animation.duration = 0.2;
    [bgView.layer setCornerRadius:defaultH*scale*0.5];
    [bgView.layer addAnimation:animation forKey:@"cornerRadius"];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.layer.bounds = CGRectMake(0, 0, defaultW*scale, defaultH*scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            bgView.layer.bounds = CGRectMake(0, 0, defaultH*scale, defaultH*scale);
            self.displayButton.transform = CGAffineTransformMakeScale(0, 0);
            self.displayButton.alpha = 0;
        } completion:^(BOOL finished) {
            self.displayButton.hidden = YES;
            [self.spinnerView startAnimating];
        }];
    }];

}

- (void)stopAnimation {
    [self.spinnerView stopAnimating];
    self.displayButton.hidden = NO;
    bgView.hidden = YES;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:
     UIViewAnimationOptionCurveLinear animations:^{
         self.displayButton.transform = CGAffineTransformMakeScale(1, 1);
         self.displayButton.alpha = 1;
     } completion:^(BOOL finished) {
     }];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.layer.bounds = CGRectMake(0, 0, defaultW, defaultH);
    } completion:^(BOOL finished) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
        animation.fromValue = [NSNumber numberWithFloat:bgView.layer.cornerRadius];
        animation.toValue = [NSNumber numberWithFloat:defaultR];
        animation.duration = 0.2;
        [bgView.layer setCornerRadius:defaultR];
        [bgView.layer addAnimation:animation forKey:@"cornerRadius"];
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            bgView.layer.bounds = CGRectMake(0, 0, defaultW, defaultH);
        } completion:^(BOOL finished) {
            self.isLoading = NO;
        }];
    }];

}

-(void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    bgView.backgroundColor = contentColor;
}

-(void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.spinnerView.tintColor = progressColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
