//
//  NSString+MD5.h
//  Gopher
//
//  Created by hztuen on 15/6/12.
//  Copyright (c) 2015年 hztuen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

-(NSString *)MD5;  //MD5加密

+(NSString*)Encryption:(NSDictionary *)data; //签名

@end
