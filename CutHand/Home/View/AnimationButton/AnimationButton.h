//
//  AnimationButton.h
//  CutHand
//
//  Created by hztuen on 2017/4/19.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMMaterialDesignSpinner.h"

@interface AnimationButton : UIButton

@property(nonatomic, assign) BOOL isLoading;
@property(nonatomic, strong) MMMaterialDesignSpinner *spinnerView;
@property(nonatomic, strong) UIColor *contentColor;//主颜色
@property(nonatomic, strong) UIColor *progressColor;//进度条颜色
@property(nonatomic, strong) UIButton *displayButton;

//开始动画
- (void)startAnimation;
//结束动画
- (void)stopAnimation;

@end
