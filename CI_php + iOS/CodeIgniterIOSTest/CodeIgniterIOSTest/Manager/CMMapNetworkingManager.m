//
//  CMMapNetworkingManager.m
//  CMMapServicesKit
//
//  Created by HeQin on 16/11/13.
//  Copyright © 2016年 cmmap. All rights reserved.
//

#import "CMMapNetworkingManager.h"
#import "CMMapNetworking.h"
@implementation CMMapNetworkingManager
static CMMapHTTPSessionManager *_manager = nil;
static NetworkStatus _status;
static CMMapNetworkStatus _mystatus;
#pragma mark - 开始监听网络
+ (void)startMonitoringNetwork
{
    CMMapNetworkReachabilityManager *manager = [CMMapNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(CMMapNetworkReachabilityStatus status) {
        switch (status)
        {
            case CMMapNetworkReachabilityStatusUnknown:
                _status(CMMapNetworkStatusUnknown);
                _mystatus = CMMapNetworkStatusUnknown;
                //NSLog(@"未知网络");
                break;
            case CMMapNetworkReachabilityStatusNotReachable:
                _status(CMMapNetworkStatusNotReachable);
                _mystatus = CMMapNetworkStatusNotReachable;
                //NSLog(@"无网络");
                break;
            case CMMapNetworkReachabilityStatusReachableViaWWAN:
                _status(CMMapNetworkStatusReachableViaWWAN);
                _mystatus = CMMapNetworkStatusReachableViaWWAN;
                //NSLog(@"手机自带网络");
                break;
            case CMMapNetworkReachabilityStatusReachableViaWiFi:
                _status(CMMapNetworkStatusReachableViaWiFi);
                _mystatus = CMMapNetworkStatusReachableViaWiFi;
                //NSLog(@"WIFI");
                break;
        }
    }];
    [manager startMonitoring];
}

+ (void)networkStatusWithBlock:(NetworkStatus)status
{
    _status = status;
}

#pragma mark - GET请求
+ (void)GET:(NSString *)URL parameters:(NSDictionary *)parameters headers:(NSDictionary *)headers timeout:(NSInteger)timeout requestType:(CMMapRequestType)requestType responseType:(CMMapResponseType)responseType  success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{

    CMMapHTTPSessionManager *manager = [self createSessionManagerWithHeaders:headers timeout:timeout responseType:responseType requestType:requestType];
    [manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if (dict) { success(dict); }
        NSLog(@"%@",dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - POST请求
+ (void)POST:(NSString *)URL parameters:(NSDictionary *)parameters headers:(NSDictionary *)headers timeout:(NSInteger)timeout requestType:(CMMapRequestType)requestType responseType:(CMMapResponseType)responseType success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{
   
}

#pragma mark - 设置CMMapHTTPSessionManager相关属性
+ (CMMapHTTPSessionManager *)createSessionManagerWithHeaders:(NSDictionary *)headers timeout:(NSInteger)timeout responseType:(CMMapResponseType)responseType requestType:(CMMapRequestType)requestType{
    CMMapHTTPSessionManager *manager = [CMMapHTTPSessionManager manager];
    

    // 设置请求头信息	application/x-www-form-urlencoded
    [manager.requestSerializer setValue:@"text/plain;text/json" forHTTPHeaderField:@"Content-Type"];
    
    // 设置服务器返回结果的类型:JSON (CMMapJSONResponseSerializer,CMMapHTTPResponseSerializer)
    // 设置返回数据类型
    switch (responseType) {
        case CMMapResponseTypeDefaut:
            manager.responseSerializer = [CMMapHTTPResponseSerializer serializer];
            break;
        case CMMapResponseTypeJson:
            manager.responseSerializer = [CMMapJSONResponseSerializer serializer];
            break;
        case CMMapResponseTypePropertyList:
            manager.responseSerializer = [CMMapPropertyListResponseSerializer serializer];
            break;
        case CMMapResponseTypeXMLParser:
            manager.responseSerializer = [CMMapXMLParserResponseSerializer serializer];
            break;
        default:
            manager.responseSerializer = [CMMapHTTPResponseSerializer serializer];
            break;
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    return manager;
}
+ (void)cancelAllRequests {
    [[CMMapHTTPSessionManager manager].operationQueue cancelAllOperations];
}

@end
