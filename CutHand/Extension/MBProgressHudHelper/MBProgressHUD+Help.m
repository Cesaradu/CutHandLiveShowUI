//
//  MBProgressHUD+Help.m
//  APPJSBridge
//
//  Created by hztuen on 16/4/6.
//  Copyright © 2016年 hztuen. All rights reserved.
//

#import "MBProgressHUD+Help.h"

@implementation MBProgressHUD (Help)

+(void)showMessage:(NSString *)string
{
    UIView* view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;
    hud.margin = 10.f;
    hud.yOffset = ScreenHeight*0.4;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.9];
}

+ (void)showActivity:(NSString *)message
{
      [self showActivity:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showActivity:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode=  MBProgressHUDModeIndeterminate;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)showProgress:(float)progress
{
    [self showProgress:progress toView:nil];
}

+ (MBProgressHUD *)showProgress:(float)progress toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode=  MBProgressHUDModeDeterminate;
     // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.progress =0;
    
    return hud;
}

 @end
