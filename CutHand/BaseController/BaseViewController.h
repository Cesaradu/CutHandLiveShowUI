//
//  BaseViewController.h
//  CutHand
//
//  Created by hztuen on 2017/4/13.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface BaseViewController : UIViewController <SDCycleScrollViewDelegate>

// 适配页面
- (float)Suit:(float)MySuit;

// 适配字体
- (float)SuitFont:(float)font;

//左侧返回按钮
- (void)buildNaviBarLelfBtn;
- (void)gotoNaviBarLelfBtn;

//轮播图
- (SDCycleScrollView *)makeShufflingView:(UIView *)set_View theImageArray:(NSArray *)imageArray AndFrame:(CGRect)frames AndPlaceholderImage:(UIImage *)placeholderImage;

/**
 *   返回 label(字位置自己设), 参数1, 颜色; 参数2, 字体大小; 参数3,字的位置
 */
- (UILabel *)labelWithColor:(NSString *)color AndFont:(CGFloat)font AndAlignment:(NSTextAlignment)alignment;

/**
 *   返回 button, 参数1, 按钮名字; 参数2, 字体颜色; 参数3, 字号; 参数4, 背景色; 参数5/6, self
 */
- (UIButton *)buttonWithTitle:(NSString *)title AndTitleColor:(NSString *)titleColor AndTitleFont:(CGFloat)titleFont AndBackgroundColor:(NSString *)bgColor addTarget:(id)target action:(SEL)action;

//计算网路请求图片大小
- (CGSize)getImageSizeWithURL:(id)imageURL;

@end
