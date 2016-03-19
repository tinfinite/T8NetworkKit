//
//  DemoService.m
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import "DemoService.h"

@implementation DemoService


+ (void)testRequestWithLimit:(NSInteger)limit last:(NSString *)last block:(RequestComplete)requestComplete
{
    NSString *urlPath = @"v2/moments";
    
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    [mutDict setObject:@(limit) forKey:@"limit"];
    if (last.length) {
        [mutDict setObject:last forKey:@"last"];
    }
    
    [T8NetworkBaseService sendRequestUrlPath:urlPath httpMethod:HttpMethodGet dictParams:mutDict completeBlock:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
        if (requestComplete) {
            requestComplete(status, data, error);
        }
    }];
}

+ (void)testRequestWithId:(NSString *)ID secret:(NSString *)secret type:(NSString *)type code:(NSString *)code uri:(NSString *)uri block:(RequestComplete)requestComplete
{
    NSString *urlPath = @"https://api.weibo.com/oauth2/access_token";
    
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    [mutDict setObject:ID forKey:@"client_id"];
    [mutDict setObject:secret forKey:@"client_secret"];
    [mutDict setObject:type forKey:@"grant_type"];
    [mutDict setObject:code forKey:@"code"];
    [mutDict setObject:uri forKey:@"redirect_uri"];

    
    [T8NetworkBaseService sendRequestUrlPath:urlPath httpMethod:HttpMethodPost dictParams:mutDict completeBlock:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
        if (requestComplete) {
            requestComplete(status, data, error);
        }
    }];
}


@end
