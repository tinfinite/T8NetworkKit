//
//  T8NetworkBaseService.m
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import "T8NetworkBaseService.h"
#import "AFNetworking.h"
#import "T8NetworkConifig.h"

@implementation T8NetworkBaseService{
    T8NetworkConifig *_config;
    AFHTTPSessionManager *_manager;
}

+ (T8NetworkBaseService *)shrareInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _config = [T8NetworkConifig sharedInstance];
        _manager = [self  shareHttpManager];
    }
    return self;
}

- (AFHTTPSessionManager *)shareHttpManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    });
    return manager;
}

- (void)sendRequestUrlPath:(NSString *)strUrlPath httpMethod:(HttpMethod)httpMethod dictParams:(NSMutableDictionary *)dictParams completeBlock:(RequestComplete)completeBlock
{
    
    NSString *method = [T8NetworkPrivate getMethodTypeString:httpMethod];
    NSString *requestUrl = [T8NetworkPrivate buildRequestUrl:_config.baseUrl detailUrl:strUrlPath];

    NSMutableURLRequest *request = [_manager.requestSerializer requestWithMethod:method URLString:requestUrl parameters:dictParams error:nil];
    if (_config.headerBlock) {
        _config.headerBlock(request);
    }
    
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            T8NetworkError *_error = [T8NetworkError errorWithNSError:error];
            completeBlock(RequestStatusFailure, nil, _error);
        } else {
            completeBlock(RequestStatusSuccess, responseObject, nil);
        }
    }];
    [dataTask resume];
}

- (void)uploadFile:(T8FileModel *)fileModel urlPath:(NSString *)urlPath params:(NSMutableDictionary *)params progressBlock:(RequestProgressBlock)progressBlock completeBlock:(RequestComplete)completeBlock
{
    AFHTTPSessionManager *manager = [self shareHttpManager];
    NSString *requetUrl = [T8NetworkPrivate buildRequestUrl:_config.baseUrl detailUrl:urlPath];

    NSMutableURLRequest *request = [manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:requetUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (fileModel.type == FileModelData) {
            if (fileModel.data) {
                [formData appendPartWithFileData:fileModel.data name:fileModel.name fileName:fileModel.fileName mimeType:fileModel.mimeType];
            }
        }else if (fileModel.type == FileModelPath){
            if (fileModel.path.length > 0) {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:fileModel.path] name:fileModel.name fileName:fileModel.fileName mimeType:fileModel.mimeType error:nil];
                NSLog(@"formData = %@", formData);
            }
        }
    } error:nil];

    if (_config.headerBlock) {
        _config.headerBlock(request);
    }

    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
//        typedef void(^RequestProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);
        progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount, 0);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                T8NetworkError *_error = [T8NetworkError errorWithNSError:error];
                completeBlock(RequestStatusFailure, nil, _error);
            } else {
                completeBlock(RequestStatusSuccess, responseObject, nil);
            }
    }];
    [uploadTask resume];
}

- (void)uploadFiles:(T8FileModelArray *)files urlPath:(NSString *)urlPath params:(NSMutableDictionary *)params progressBlock:(RequestProgressBlock)progressBlock completeBlock:(RequestComplete)completeBlock;
{
    NSString *requestUrl = [T8NetworkPrivate buildRequestUrl:_config.baseUrl detailUrl:urlPath];
    NSArray *fileModelArray = files.fileModelArray;
    
    NSMutableURLRequest *request = [_manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (T8FileModel *fileModel in fileModelArray) {
            if (fileModel.type == FileModelData) {
                if (fileModel.data) {
                    [formData appendPartWithFileData:fileModel.data name:fileModel.name fileName:fileModel.fileName mimeType:fileModel.mimeType];
                }
            }else if (fileModel.type == FileModelPath){
                if (fileModel.path.length > 0) {
                    [formData appendPartWithFileURL:[NSURL fileURLWithPath:fileModel.path] name:fileModel.name fileName:fileModel.fileName mimeType:fileModel.mimeType error:nil];
                }
            }
        }
    } error:nil];
    
    if (_config.headerBlock) {
        _config.headerBlock(request);
    }
    
    NSURLSessionUploadTask *uploadTask = [_manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount, 0);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            T8NetworkError *_error = [T8NetworkError errorWithNSError:error];
            completeBlock(RequestStatusFailure, nil, _error);
        } else {
            completeBlock(RequestStatusSuccess, responseObject, nil);
        }
    }];
    [uploadTask resume];
}
@end

@implementation T8FileModel

@end

@implementation T8FileModelArray

@end