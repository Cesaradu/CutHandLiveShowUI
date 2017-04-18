//
//  ModelData.h
//  OKSheng
//
//  Created by hztuen on 17/3/13.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelData : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *deviceToken;

@property (nonatomic, assign) int goodsCategoryId;


+ (ModelData *)sharedData;


@end
