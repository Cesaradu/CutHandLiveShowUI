//
//  AnimationButton.m
//  CutHand
//
//  Created by hztuen on 2017/4/17.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "AnimationButton.h"
#import "CircleAnimationView.h"
static NSTimeInterval startDuration = 0.3;
static NSTimeInterval endDuration = 0.5;
@interface AnimationButton ()
@property (nonatomic, strong) CircleAnimationView* circleView;
@property (nonatomic, assign) CGRect origionRect;
@end
@implementation AnimationButton
- (CircleAnimationView *)circleView
{
    if (!_circleView) {
        _circleView = [CircleAnimationView viewWithButton:self];
        [self addSubview:_circleView];
    }
    return _circleView;
}

+(instancetype)buttonWithFrame:(CGRect)frame{
    AnimationButton* button = [AnimationButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    button.layer.cornerRadius = frame.size.height / 2;
    button.layer.masksToBounds = YES;
    button.clipsToBounds = NO;
    button.origionRect = button.frame;
    return button;
}


-(void)setborderColor:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
    
}

-(void)setborderWidth:(CGFloat)width{
    self.layer.borderWidth = width;
}



-(void)startAnimation{
    CGPoint center = self.center;
    CGFloat width = self.layer.cornerRadius * 2;
    CGFloat height = self.frame.size.height;
    CGRect desFrame = CGRectMake(center.x - width / 2, center.y - height / 2, width, height);
    
    self.userInteractionEnabled = NO;
    
    if ([self.delegate respondsToSelector:@selector(AnimationButtonDidStartAnimation:)]) {
        [self.delegate AnimationButtonDidStartAnimation:self];
    }
    
    [UIView animateWithDuration:startDuration animations:^{
        self.titleLabel.alpha = .0f;
        self.frame = desFrame;
    } completion:^(BOOL finished) {
        
        [self.circleView startAnimation];
    }];
}

-(void)stopAnimation{
    self.userInteractionEnabled = YES;
    
    
    if ([self.delegate respondsToSelector:@selector(AnimationButtonWillFinishAnimation:)]) {
        [self.delegate AnimationButtonWillFinishAnimation:self];
    }
    
    [self.circleView removeFromSuperview];
    self.circleView = nil;
    [UIView animateWithDuration:endDuration animations:^{
        self.frame = self.origionRect;
        self.titleLabel.alpha = 1.0f;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(AnimationButtonDidFinishAnimation:)]) {
            [self.delegate AnimationButtonDidFinishAnimation:self];
        }
    }];
    
}
@end
