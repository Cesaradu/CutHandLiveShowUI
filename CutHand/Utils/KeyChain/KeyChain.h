//
//  KeyChain.h
//  OKSheng
//
//  Created by hztuen on 17/3/20.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface KeyChain : NSObject

// save username and password to keychain 存
+ (void)save:(NSString *)service data:(id)data;

// take out username and passwore from keychain 取
+ (id)load:(NSString *)service;

// delete username and password from keychain 删
+ (void)delete:(NSString *)service;

@end
