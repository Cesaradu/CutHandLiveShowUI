//
//  MBProgressHUD+Help.h
//  APPJSBridge
//
//  Created by hztuen on 16/4/6.
//  Copyright © 2016年 hztuen. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Help)

+(void)showMessage:(NSString *)string;
+ (void)showActivity:(NSString *)message;
+ (void)hideHUD;
+ (void)showProgress:(float)progress;
+ (MBProgressHUD *)showProgress:(float)progress toView:(UIView *)view;


@end
