//
//  NSString+MD5.m
//  Gopher
//
//  Created by hztuen on 15/6/12.
//  Copyright (c) 2015年 hztuen. All rights reserved.
//
#define CC_MD5_DIGEST_LENGTH 16

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString *)MD5
{
    return [NSString MD5ByAStr:self];
}

+ (NSString *)MD5ByAStr:(NSString *)aSourceStr
{
    const char* cStr = [aSourceStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
     CC_MD5(cStr, strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
     return ret;
}

+(NSString*)Encryption:(NSDictionary *)data  //加密
{
    NSArray *keys=[[data allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSString *string0=  [keys firstObject];
    
    NSString *stringA=[NSString stringWithFormat:@"%@=%@",string0,data[string0]];
    
    for(int i=1;i<keys.count;i++)
    {
        NSString *file=[keys objectAtIndexCheck:i];
        NSString *string=[NSString stringWithFormat:@"%@=%@",file,[data objectForKey:file]];
        stringA = [stringA stringByAppendingFormat:@"&%@",string];
    }
    
    stringA= [stringA stringByAppendingString:@"A984-67E7D2"];
    
    return  stringA;
}

@end
