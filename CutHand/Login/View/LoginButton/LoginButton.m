//
//  LoginButton.m
//  CutHand
//
//  Created by hztuen on 2017/5/10.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "LoginButton.h"

@implementation LoginButton {
    CGFloat defaultW;
    CGFloat defaultH;
    CGFloat defaultR;
    CGFloat scale;
    UIView *bgView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSetting];
    }
    return self;
}

- (void)initSetting {
    scale = 1.1;
    bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor colorWithHexString:@"c0c0c0" alpha:1.0];
    bgView.userInteractionEnabled = NO;
    bgView.hidden = YES;
    [self addSubview:bgView];
    
    defaultW = bgView.frame.size.width;
    defaultH = bgView.frame.size.height;
    defaultR = bgView.layer.cornerRadius;
    
    ProgressView *progressView = [[ProgressView alloc] initWithFrame:CGRectZero];
    self.progressView = progressView;
    self.progressView.bounds = CGRectMake(0, 0, defaultH*0.8, defaultH*0.8);
    self.progressView.tintColor = [UIColor whiteColor];
    self.progressView.lineWidth = 2;
    self.progressView.center = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
    self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
    self.progressView.userInteractionEnabled = NO;
    [self addSubview:self.progressView];
    
    [self initBtn];
    
}

- (void)initBtn {
    self.forDisplayButton = [[UIButton alloc] initWithFrame:self.bounds];
    self.forDisplayButton.userInteractionEnabled = NO;
    [self addSubview:self.forDisplayButton];
}


-(void)setContentColor:(UIColor *)contentColor{
    _contentColor = contentColor;
    bgView.backgroundColor = contentColor;
}

-(void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    self.progressView.tintColor = progressColor;
}

- (void)startAnimation {
    bgView.hidden = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:defaultR];
    animation.toValue = [NSNumber numberWithFloat:defaultH*scale*0.5];
    animation.duration = 0.3;
    [bgView.layer setCornerRadius:defaultH*0.5];
    [bgView.layer addAnimation:animation forKey:@"cornerRadius"];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.layer.bounds = CGRectMake(0, 0, defaultW*scale, defaultH*scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            bgView.layer.bounds = CGRectMake(0, 0, defaultH, defaultH);
            self.forDisplayButton.transform = CGAffineTransformMakeScale(0, 0);
            self.forDisplayButton.alpha = 0;
        } completion:^(BOOL finished) {
            self.forDisplayButton.hidden = YES;
            [self.progressView startAnimating];
        }];
    }];
}

- (void)stopAnimation {
    [self.progressView stopAnimating];
    self.forDisplayButton.hidden = NO;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:
     UIViewAnimationOptionCurveLinear animations:^{
         self.forDisplayButton.transform = CGAffineTransformMakeScale(1, 1);
         self.forDisplayButton.alpha = 1;
     } completion:^(BOOL finished) {
     }];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        bgView.layer.bounds = CGRectMake(0, 0, defaultW*scale, defaultH*scale);
    } completion:^(BOOL finished) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.fromValue = [NSNumber numberWithFloat:bgView.layer.cornerRadius];
        animation.toValue = [NSNumber numberWithFloat:defaultR];
        animation.duration = 0.3;
        [bgView.layer setCornerRadius:defaultR];
        [bgView.layer addAnimation:animation forKey:@"cornerRadius"];
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            bgView.layer.bounds = CGRectMake(0, 0, defaultW, defaultH);
        } completion:^(BOOL finished) {
            bgView.hidden = YES;
        }];
    }];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self.forDisplayButton setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self.forDisplayButton setHighlighted:highlighted];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
