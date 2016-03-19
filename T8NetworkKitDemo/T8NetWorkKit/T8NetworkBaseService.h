//
//  T8NetworkBaseService.h
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import <Foundation/Foundation.h>
@class T8NetworkError;

typedef NS_ENUM(NSInteger, RequestStatus)
{
    RequestStatusSuccess,
    RequestStatusFailure
};

typedef NS_ENUM(NSInteger, HttpMethod) {
    HttpMethodGet,
    HttpMethodPost,
    HttpMethodPut,
    HttpMethodDelete,
    HttpMethodPatch,
    HttpMethodHead
};

typedef void(^RequestComplete)(RequestStatus status, NSDictionary *data, T8NetworkError *error);
typedef void(^RequestHandleBlock)(NSMutableURLRequest *request);
typedef void(^RequestProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

@interface T8NetworkBaseService : NSObject

+ (void)setBaseUrl:(NSString *)baseUrl;

+ (void)setHandleBlock:(RequestHandleBlock)handleBlock;

+ (void)sendRequestUrlPath:(NSString *)strUrlPath httpMethod:(HttpMethod)httpMethod dictParams:(NSMutableDictionary *)dictParams completeBlock:(RequestComplete)completeBlock;

+ (void)sendRequestUrlPath:(NSString *)strUrlPath httpMethod:(HttpMethod)httpMethod dictParams:(NSMutableDictionary *)dictParams completeBlock:(RequestComplete)completeBlock useCacheWhenFail:(BOOL)cache;

@end
