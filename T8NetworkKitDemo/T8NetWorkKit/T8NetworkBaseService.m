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
static RequestHeaderBlock T8RequestHeaderBlock = nil;

@implementation T8NetworkBaseService

+ (void)setBaseUrl:(NSString *)baseUrl
{
    T8BaseNetworkUrl = baseUrl;
}

+ (void)setHeaderBlock:(RequestHeaderBlock)headerBlock
{
    T8RequestHeaderBlock = headerBlock;
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
    AFHTTPSessionManager *manager = [self shareHttpManager];
    
    NSString *method = [self getMethodTypeString:httpMethod];
    NSString *urlStr = [self getRequestUrl:strUrlPath];
    NSLog(@"%@", urlStr);
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:urlStr parameters:dictParams error:nil];
    if (T8RequestHeaderBlock) {
        T8RequestHeaderBlock(request);
    }
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            T8NetworkError *_error = [T8NetworkError errorWithNSError:error];
            completeBlock(RequestStatusFailure, nil, _error);
        } else {
            completeBlock(RequestStatusSuccess, responseObject, nil);
        }
    }];
    [dataTask resume];
}

+ (void)uploadFile:(FileModel *)fileModel urlPath:(NSString *)urlPath params:(NSMutableDictionary *)params progressBlock:(RequestProgressBlock)progressBlock completBlock:(RequestComplete)completBlock
{
    AFHTTPSessionManager *manager = [self shareHttpManager];
    
    NSURL *URL = [NSURL URLWithString:urlPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    if (T8RequestHeaderBlock) {
        T8RequestHeaderBlock(request);
    }
    
    NSString *type = fileModel.type;
    NSURLSessionUploadTask *uploadTask = nil;
    if ([type isEqualToString:@"data"]) {
        NSURL *filePath = [NSURL fileURLWithPath:fileModel.fileName];
        
        uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
        }];
    } else if ([type isEqualToString:@"path"]) {
        uploadTask = [manager uploadTaskWithRequest:request fromData:fileModel.data progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
        }];
    }
    [uploadTask resume];
}



+ (void)uploadFiles:(FileModelArray *)files urlPath:(NSString *)strUrlPath params:(NSMutableDictionary *)params progressBlock:(RequestProgressBlock)progressBlock completBlock:(RequestComplete)completBlock;
{
    NSArray *fileModelArray = files.fileModelArray;
    
    for (id fileModel in fileModelArray) {
        if ([fileModel isKindOfClass:[FileModel class]]) {
            [self uploadFile:fileModel urlPath:strUrlPath params:params progressBlock:progressBlock completBlock:completBlock];
        }
    }
}

#pragma mark Private

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

@implementation FileModel

@end

@implementation FileModelArray

@end