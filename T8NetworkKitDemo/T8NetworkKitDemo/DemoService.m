//
//  DemoService.m
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import "DemoService.h"
#import "MJExtension.h"
#import "PostParams.h"
#import "GetParams.h"

@implementation DemoService

+ (void)testRequestWithGetParmas:(GetParams *)getParams block:(RequestComplete)requestComplete
{
    NSString *urlPath = @"v2/moments";
    
    NSMutableDictionary *mulDict = getParams.mj_keyValues;
    [T8NetworkBaseService sendRequestUrlPath:urlPath httpMethod:HttpMethodGet dictParams:mulDict completeBlock:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
        if (requestComplete) {
            requestComplete(status, data, error);
        }
    }];

}

+ (void)testRequestWithPostParams:(PostParams *)postParams block:(RequestComplete)requestComplete
{
    NSString *urlPath = @"https://api.weibo.com/oauth2/access_token";
    
    //将模型数据postParams -> Json
    NSMutableDictionary *mulDict = postParams.mj_keyValues;
    
    [T8NetworkBaseService sendRequestUrlPath:urlPath httpMethod:HttpMethodPost dictParams:mulDict completeBlock:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
        if (requestComplete) {
            requestComplete(status, data, error);
        }
    }];

}


@end
