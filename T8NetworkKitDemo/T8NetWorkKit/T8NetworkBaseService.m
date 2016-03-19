//
//  T8NetworkBaseService.m
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import "T8NetworkBaseService.h"
#import "AFNetworking.h"
#import "T8NetworkError.h"

static NSString *T8BaseNetworkUrl = nil;
static RequestHandleBlock T8RequestHandleBlock = nil;

@implementation T8NetworkBaseService

+ (void)setBaseUrl:(NSString *)baseUrl
{
    T8BaseNetworkUrl = baseUrl;
}

+ (void)setHandleBlock:(RequestHandleBlock)handleBlock
{
    T8RequestHandleBlock = handleBlock;
}

+ (AFHTTPSessionManager *)shareHttpManager
{
    static AFHTTPSessionManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    });
    return _manager;
}

+ (void)sendRequestUrlPath:(NSString *)strUrlPath httpMethod:(HttpMethod)httpMethod dictParams:(NSMutableDictionary *)dictParams completeBlock:(RequestComplete)completeBlock
{
    [self sendRequestUrlPath:strUrlPath httpMethod:httpMethod dictParams:dictParams completeBlock:completeBlock cachePolicy:-1];
}

+ (void)sendRequestUrlPath:(NSString *)strUrlPath httpMethod:(HttpMethod)httpMethod dictParams:(NSMutableDictionary *)dictParams completeBlock:(RequestComplete)completeBlock useCacheWhenFail:(BOOL)cache
{
    if (cache) {
        [self sendRequestUrlPath:strUrlPath httpMethod:httpMethod dictParams:dictParams completeBlock:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
            if (status == RequestStatusSuccess) {
                completeBlock(status, data, error);
            }else{
                [T8NetworkBaseService sendRequestUrlPath:strUrlPath httpMethod:httpMethod dictParams:dictParams completeBlock:completeBlock cachePolicy:NSURLRequestReturnCacheDataDontLoad];
            }
        }];
    }else{
        [self sendRequestUrlPath:strUrlPath httpMethod:httpMethod dictParams:dictParams completeBlock:completeBlock];
    }
}



+ (void)sendRequestUrlPath:(NSString *)strUrlPath httpMethod:(HttpMethod)httpMethod dictParams:(NSMutableDictionary *)dictParams completeBlock:(RequestComplete)completeBlock cachePolicy:(NSURLRequestCachePolicy)policy
{
    AFHTTPSessionManager *manager = [self shareHttpManager];
    
    NSString *method = [self getMethodTypeString:httpMethod];
    NSString *urlStr = [self getRequestUrl:strUrlPath];
    NSLog(@"%@", urlStr);
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:urlStr parameters:dictParams error:nil];
    request.cachePolicy = policy;
    if (T8RequestHandleBlock) {
        T8RequestHandleBlock(request);
    }
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}


#pragma mark Private
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param result  请求成功或失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(RequestComplete)result andRequest:(NSMutableURLRequest *)request;
{
    AFHTTPSessionManager *manager = [self shareHttpManager];

    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@", downloadProgress.localizedDescription);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (result != nil) {
            result(RequestStatusSuccess, responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (result != nil) {
            T8NetworkError *_error = [T8NetworkError errorWithNSError:error];
            NSLog(@"%@",_error);
            result(RequestStatusFailure, nil, _error);
        }
    }];
    
}


/**
 *  HTTP方法:枚举->字符串
 */
+ (NSString *)getMethodTypeString:(HttpMethod)httpMethod{
    NSString *method = nil;
    switch(httpMethod) {
        case HttpMethodGet:
            method = @"GET";
            break;
        case HttpMethodPost:
            method = @"POST";
            break;
        case HttpMethodPut:
            method = @"PUT";
            break;
        case HttpMethodDelete:
            method = @"DELETE";
            break;
        case HttpMethodPatch:
            method = @"PATCH";
            break;
        case HttpMethodHead:
            method = @"HEAD";
            break;
        default:
            break;
    }
    return method;
}

/**
 *  拼接URL:baseURL+服务路径
 */
+ (NSString *)getRequestUrl:(NSString *)path
{
    if ([path hasPrefix:@"http"]) {
        return path;
    }
    
    if (T8BaseNetworkUrl.length>0) {
        return [NSString stringWithFormat:@"%@/%@", T8BaseNetworkUrl, path];
    }else{
        return path;
    }
}





@end
