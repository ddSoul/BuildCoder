//
//  XLHttpTool.m
//  Anxinlicai
//
//  Created by 邓西亮 on 16/7/28.
//  Copyright © 2016年 邓西亮. All rights reserved.
//

#import "XLHttpTool.h"

@implementation XLHttpTool

// get形式请求网络数据
+ (void)getWithUrl:(NSString *)urlStr params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"eb0d7633268c4e4d346bd6cfa57a47e5" forHTTPHeaderField:@"apikey"];
    manager.requestSerializer.timeoutInterval = 8.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    NSLog(@"---_____%@",urlStr);
    [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"这里打印请求成功要做的事");

             if (success) {
                 
                     success(responseObject);
             }

            }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             if (failure) {
                 failure(error);
             }
             
             
         }];
    
    
}
// post形式请求网络数据
+ (void)postWithUrl:(NSString *)urlStr params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 8.0f;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    [manager.requestSerializer setValue:urlPath(@"Bearer ", _accessToken) forHTTPHeaderField:@"Authorization"];
    [manager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"这里打印请求成功要做的事");
             // 在回调之前一定要判断block是否有值
             if (success) {
                 //                 // 回调结果
                 
                 success(responseObject);
             }
             //
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             if (failure) {
                 failure(error);
             }
             
             
         }];

    
}

// put形式请求网络数据
+ (void)putWithUrl:(NSString *)urlStr params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 8.0f;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];


}
// del形式请求网络数据
+ (void)delWithUrl:(NSString *)urlStr params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 8.0f;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

            [manager DELETE:@"" parameters:nil
             
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        
                }
                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {


                }];

}

@end
