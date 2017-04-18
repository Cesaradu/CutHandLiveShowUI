//
//  UIButton+Extension.h
//  OKSheng
//
//  Created by hztuen on 17/3/20.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 *   返回 文本button, 参数1, 按钮名字; 参数2, 字体颜色; 参数3, 字号; 参数4, 背景色; 参数5/6, self
 */
+ (UIButton *)buttonWithTitle:(NSString *)title AndTitleColor:(NSString *)titleColor AndTitleFont:(CGFloat)titleFont AndBackgroundColor:(NSString *)bgColor addTarget:(id)target action:(SEL)action;

/**
 *   返回 图片button, 参数1, 图片名字; 参数2, frame; 参数3/4, self
 */
+ (UIButton *)buttonWithImageName:(NSString *)imageName WithFrame:(CGRect)frame WithTarget:(id)target action:(SEL)action;

/**
 *   返回  带圆角边框文本button, 参数1, 按钮名字; 参数2, 字体颜色; 参数3, 字号; 参数4, 背景色; 参数5，圆角；参数6／7，边框 参数8/9, self
 *   若不需要圆角和边框，cornerRadius和borderWidth传0
 */
+ (UIButton *)buttonWithTitle:(NSString *)title AndTitleColor:(NSString *)titleColor AndTitleFont:(CGFloat)titleFont AndBackgroundColor:(NSString *)bgColor AndCornerRadius:(CGFloat)cornerRadius AndBorderColor:(NSString *)borderColor AndBorderWidth:(CGFloat)borderWidth addTarget:(id)target action:(SEL)action;


@end
