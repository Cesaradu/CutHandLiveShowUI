//
//  BaseRequest.m
//  BaseFramework
//
//  Created by hztuen on 17/3/2.
//  Copyright © 2017年 Cesar. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

// POST 请求数据基类
+ (void)postRequest:(NSMutableDictionary *)dict AndUrl:(NSString *)url success:(void(^)(id responseDict))success fail:(void(^)(NSError * error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    //签名
//    NSMutableDictionary  *dic  = [[NSMutableDictionary alloc]init];
//    
//    NSDate         *date       = [NSDate date];
//    NSTimeZone     *zone       = [NSTimeZone systemTimeZone];
//    NSInteger      interval    = [zone secondsFromGMTForDate:date];
//    NSDate         *localDate  = [date dateByAddingTimeInterval:interval];
//    NSTimeInterval startTime   = [localDate timeIntervalSince1970];
//    NSString       *timeString = [NSString stringWithFormat:@"%.f", startTime];
//    long int       sumTime     = timeString.longLongValue - 28800;
//    
//    [dic setObject:[NSNumber numberWithLong:sumTime] forKey:@"timeStamp"];
//
//    [dic addEntriesFromDictionary:dict];
    
    NSLog(@"参数 = %@", dict);
    
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         success(responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         fail(error);
     }];
}

// GET 请求数据基类
+ (void)getRequest:(NSMutableDictionary *)dict AndUrl:(NSString *)url success:(void(^)(id responseDict))success fail:(void(^)(NSError * error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSLog(@"参数 = %@", dict);
    
    [manager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
    }];
}

// 上传图片基类
+ (void)uploadImage:(UIImage *)img AndUrl:(NSString *)url success:(void(^)(id responseDict))success fail:(void(^)(NSError * error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData: UIImageJPEGRepresentation(img ,0.1) name:@"imgFile" fileName:@"formname.jpg" mimeType:@"jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
    }];
}

//字典转json
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    if ([NSJSONSerialization isValidJSONObject:dic])
    {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
        NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return nil;
    
}


@end
