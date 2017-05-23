//
//  CheckCodeButton.h
//  CutHand
//
//  Created by hztuen on 2017/5/11.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckCodeButton : UIButton

@property (nonatomic, assign) int second;//秒数
@property (nonatomic, strong) UILabel *timeLabel;//倒计时

- (void)destroyTimer;
- (void)startDecreaseTime;

@end
