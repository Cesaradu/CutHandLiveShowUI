//
//  BaseRequest.h
//  BaseFramework
//
//  Created by hztuen on 17/3/2.
//  Copyright © 2017年 Cesar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject

//post请求数据
+ (void)postRequest:(NSMutableDictionary *)dict AndUrl:(NSString *)url success:(void(^)(id responseDict))success fail:(void(^)(NSError * error))fail;

//get请求数据
+ (void)getRequest:(NSMutableDictionary *)dict AndUrl:(NSString *)url success:(void(^)(id responseDict))success fail:(void(^)(NSError * error))fail;

//上传图片
+ (void)uploadImage:(UIImage *)img AndUrl:(NSString *)url success:(void(^)(id responseDict))success fail:(void(^)(NSError * error))fail;

@end
