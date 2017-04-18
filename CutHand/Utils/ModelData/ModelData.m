//
//  ModelData.m
//  OKSheng
//
//  Created by hztuen on 17/3/13.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import "ModelData.h"

@implementation ModelData

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+ (ModelData *)sharedData
{
    static ModelData *sharedObj = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObj = [[ModelData alloc]init];
    });
    return sharedObj;
}


@end
