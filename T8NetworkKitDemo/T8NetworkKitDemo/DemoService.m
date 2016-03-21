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
#import <UIKit/UIKit.h>

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
//+ (void)uploadFile:(T8FileModel *)fileModel urlPath:(NSString *)strUrlPath params:(NSMutableDictionary *)params progressBlock:(RequestProgressBlock)progressBlock completBlock:(RequestComplete)completBlock;

+ (void)testUploads:(T8FileModel *)fileModel block:(RequestComplete)requestComplete
{
    NSString *urlPath = @"v2/upload/picture";
//    NSString *urlPath = @"https://slack.com/api/files.upload?token=xoxp-28180523860-28139895139-28194787457-d910c3f484&filename=abc&pretty=1";
    
    [T8NetworkBaseService uploadFile:fileModel urlPath:urlPath params:nil progressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"bytesWritten:%lu", (unsigned long)bytesWritten);
        NSLog(@"totalBytesWritten:%lld", totalBytesWritten);
    } completeBlock:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
        if (requestComplete) {
            requestComplete(status, data, error);
        }
    }];
}

+ (void)testFilesUploads:(T8FileModelArray *)fileModelArray block:(RequestComplete)requestComplete
{
    NSString *urlPath = @"v2/upload/picture";
    //    NSString *urlPath = @"https://slack.com/api/files.upload?token=xoxp-28180523860-28139895139-28194787457-d910c3f484&filename=abc&pretty=1";
    
    [T8NetworkBaseService uploadFiles:fileModelArray urlPath:urlPath params:nil progressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"bytesWritten:%lu", (unsigned long)bytesWritten);
        NSLog(@"totalBytesWritten:%lld", totalBytesWritten);

    } completeBlock:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
        if (requestComplete) {
            requestComplete(status, data, error);
        }
    }];
}




@end
