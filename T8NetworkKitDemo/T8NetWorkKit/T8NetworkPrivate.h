//
//  T8NetworkPrivate.h
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/23.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HttpMethod) {
    HttpMethodGet,
    HttpMethodPost,
    HttpMethodPut,
    HttpMethodDelete,
    HttpMethodPatch,
    HttpMethodHead
};

@interface T8NetworkPrivate : NSURLRequest
/**
 *  为url添加公共参数
 */
+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters;

/**
 *  HTTP方法 枚举->字符
*/
+ (NSString *)getMethodTypeString:(HttpMethod)httpMethod;

/**
 *  拼接请求URL
 */
+ (NSString *)buildRequestUrl:(NSString *)baseUrl detailUrl:(NSString *)detailUrl;
@end
