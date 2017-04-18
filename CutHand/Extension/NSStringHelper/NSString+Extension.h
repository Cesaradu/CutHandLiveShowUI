//
//  NSString+Extension.h
//  OKSheng
//
//  Created by hztuen on 17/3/20.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

//判断字符串是否为空
+ (BOOL)isNULL:(id)string;

/*
 把JSON格式的字符串转换成字典
 */
- (NSDictionary *)StringOfJsonConversionDictionary;

@end
