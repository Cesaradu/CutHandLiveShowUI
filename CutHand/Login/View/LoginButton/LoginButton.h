//
//  LoginButton.h
//  CutHand
//
//  Created by hztuen on 2017/5/10.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"

@interface LoginButton : UIControl

@property (nonatomic, strong) ProgressView *progressView;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, strong) UIButton *forDisplayButton;

- (void)startAnimation;
- (void)stopAnimation;

@end
