//
//  UIButton+Extension.m
//  OKSheng
//
//  Created by hztuen on 17/3/20.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

//创建文本button, 位置自己写
+ (UIButton *)buttonWithTitle:(NSString *)title AndTitleColor:(NSString *)titleColor AndTitleFont:(CGFloat)titleFont AndBackgroundColor:(NSString *)bgColor addTarget:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    if (title)
    {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:titleColor alpha:1.0] forState:UIControlStateNormal];
    }
    if (bgColor)
    {
        [button setBackgroundColor:[UIColor colorWithHexString:bgColor alpha:1.0]];
    }
    if (target && action)
    {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

//图片按钮
+ (UIButton *)buttonWithImageName:(NSString *)imageName WithFrame:(CGRect)frame WithTarget:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (target && action)
    {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

/**
 *   返回  带圆角边框文本button, 参数1, 按钮名字; 参数2, 字体颜色; 参数3, 字号; 参数4, 背景色; 参数5／6，圆角；参数7／8，边框 参数9/10, self
 */
+ (UIButton *)buttonWithTitle:(NSString *)title AndTitleColor:(NSString *)titleColor AndTitleFont:(CGFloat)titleFont AndBackgroundColor:(NSString *)bgColor AndCornerRadius:(CGFloat)cornerRadius AndBorderColor:(NSString *)borderColor AndBorderWidth:(CGFloat)borderWidth addTarget:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    if (title)
    {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:titleColor alpha:1.0] forState:UIControlStateNormal];
    }
    if (bgColor)
    {
        [button setBackgroundColor:[UIColor colorWithHexString:bgColor alpha:1.0]];
    }
    
    if (cornerRadius)
    {
        button.layer.cornerRadius = cornerRadius;
        button.layer.masksToBounds = YES;
    }
    
    if (borderWidth)
    {
        button.layer.borderWidth = borderWidth;
        button.layer.borderColor = [UIColor colorWithHexString:borderColor alpha:1.0].CGColor;
    }
    
    if (target && action)
    {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

@end
