//
//  Define.h
//  CutHand
//
//  Created by hztuen on 2017/4/13.
//  Copyright © 2017年 cesar. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define MainColor   @"FA5F62"
#define BGColor     @"f6f6f6"

// 在release版本中关闭NSLog打印
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

//屏幕宽高
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define Width           self.view.frame.size.width
#define Height          self.view.frame.size.height

/**
 适配 给定4.7寸屏尺寸，适配4和5.5寸屏尺寸
 */
#define Suit55Inch           1.104
#define Suit4Inch            1.171875

//屏幕适配比例 (从小往大适配)
//#define Suit47Inch           1.104
//#define Suit4Inch            1.29375

// 系统判定
#define IOS_VERSION    [[[UIDevice currentDevice]systemVersion]floatValue]
#define IS_IOS8        (IOS_VERSION>=8.0)
#define IS_IOS7        (IOS_VERSION>=7.0)
#define Is_IOS9        (IOS_VERSION>=9.0 && IOS_VERSION<10)

// 屏幕判定
#define IS_IPHONE35INCH  ([SDiPhoneVersion deviceSize] == iPhone35inch ? YES : NO)//4, 4S
#define IS_IPHONE4INCH  ([SDiPhoneVersion deviceSize] == iPhone4inch ? YES : NO)//5, 5C, 5S, SE
#define IS_IPHONE47INCH  ([SDiPhoneVersion deviceSize] == iPhone47inch ? YES : NO)//6, 6S, 7
#define IS_IPHONE55INCH ([SDiPhoneVersion deviceSize] == iPhone55inch ? YES : NO)//6P, 6SP, 7P

// Set UserDefaults
#define DefaultsSet(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
// Get UserDefaultValue
#define ValueGet(key)  [[NSUserDefaults standardUserDefaults] objectForKey:key]? [[NSUserDefaults standardUserDefaults] objectForKey:key] : @""


#define  KEY_UUID @"com.cesar.CutHand.uuid"
#define  KEY_DEVICE_TOKEN @"com.cesar.CutHand.deviceToken"


#endif /* Define_h */
