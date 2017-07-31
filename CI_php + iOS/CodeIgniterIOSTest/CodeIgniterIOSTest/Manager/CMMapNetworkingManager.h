//
//  CMMapNetworkingManager.h
//  CMMapServicesKit
//
//  Created by HeQin on 16/11/13.
//  Copyright © 2016年 cmmap. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CMMapNetworkStatus) {
    /** 未知网络*/
    CMMapNetworkStatusUnknown,
    /** 无网络*/
    CMMapNetworkStatusNotReachable,
    /** 手机网络*/
    CMMapNetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    CMMapNetworkStatusReachableViaWiFi
};

typedef NS_ENUM(NSUInteger, CMMapRequestType) {
    /** 请求类型默认*/
    CMMapRequestTypeDefaut       = 0,
    /** 请求数据类型为Json*/
    CMMapRequestTypeJson         = 1,
    /** 请求数据类型为PropertyList*/
    CMMapRequestTypePropertyList = 2
};
typedef NS_ENUM(NSUInteger, CMMapResponseType) {
    /** 返回数据类型默认*/
    CMMapResponseTypeDefaut          = 0,
    /** 返回数据类型为Json*/
    CMMapResponseTypeJson            = 1,
    /** 返回数据类型为PropertyList*/
    CMMapResponseTypePropertyList    = 2,
    /** 返回数据类型为XMLParser*/
    CMMapResponseTypeXMLParser       = 3
    
};

/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(NSDictionary *responseObject);

/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError *error);

/** 网络状态的Block*/
typedef void(^NetworkStatus)(CMMapNetworkStatus status);

/** 请求任务 */
typedef NSURLSessionTask CMMapURLSessionTask;

#pragma mark - 网络数据请求类


@interface CMMapNetworkingManager : NSObject

/**
 *  开始监听网络状态
 */
+ (void)startMonitoringNetwork;

/**
 *  实时获取网络状态回调
 */
+ (void)networkStatusWithBlock:(NetworkStatus)status;


/**
 *  GET请求,自定义请求头
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param headers      请求头参数
 *  @param timeout      超时时间
 *  @param requestType  请求数据类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 */
+ (void)GET:(NSString *)URL parameters:(NSDictionary *)parameters headers:(NSDictionary *)headers timeout:(NSInteger)timeout requestType:(CMMapRequestType)requestType responseType:(CMMapResponseType)responseType  success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

/**
 *  POST请求，默认请求头
 *
 *  @param URL          请求地址
 *  @param parameters   请求参数
 *  @param headers      请求头参数
 *  @param timeout      超时时间
 *  @param requestType  请求数据类型
 *  @param responseType 返回数据类型
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 *
 */
+ (void)POST:(NSString *)URL parameters:(NSDictionary *)parameters headers:(NSDictionary *)headers timeout:(NSInteger)timeout requestType:(CMMapRequestType)requestType responseType:(CMMapResponseType)responseType success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;


+ (void)cancelAllRequests;

@end
