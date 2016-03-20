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
typedef void(^RequestHeaderBlock)(NSMutableURLRequest *request);
typedef void(^RequestProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

/**
 *  文件模型
 */
@interface FileModel : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, strong) NSData *data;

@end

/**
 *  文件模型数据
 */
@interface FileModelArray : NSObject
@property (nonatomic, strong) NSArray *fileModelArray;

@end


@interface T8NetworkBaseService : NSObject

/**
 *  设置URL
 */
+ (void)setBaseUrl:(NSString *)baseUrl;

/**
 *  设置header参数
 */
+ (void)setHeaderBlock:(RequestHeaderBlock)headerBlock;

/**
 *  根据HTTP方法获取数据
 *
 *  @param strUrlPath    接口的地址
 *  @param httpMethod    HTTP方法
 *  @param dictParams    参数
 *  @param completeBlock 回调方法
 */
+ (void)sendRequestUrlPath:(NSString *)strUrlPath httpMethod:(HttpMethod)httpMethod dictParams:(NSMutableDictionary *)dictParams completeBlock:(RequestComplete)completeBlock;
/**
 *  上传单个文件
 *
 *  @param fileModel     文件模型
 *  @param strUrlPath    上传接口地址
 *  @param params        参数
 *  @param progressBlock 上传进度回调方法
 *  @param completBlock  上传成功回调方法
 */
+ (void)uploadFile:(FileModel *)fileModel urlPath:(NSString *)strUrlPath params:(NSMutableDictionary *)params progressBlock:(RequestProgressBlock)progressBlock completBlock:(RequestComplete)completBlock;

/**
 *  上传一组文件
 *
 *  @param files         文件模型数据
 *  @param strUrlPath    上传接口地址
 *  @param params        参数
 *  @param progressBlock 上传进度回调方法
 *  @param completBlock  上传完成回调方法
 */
+ (void)uploadFiles:(FileModelArray *)files urlPath:(NSString *)strUrlPath params:(NSMutableDictionary *)params progressBlock:(RequestProgressBlock)progressBlock completBlock:(RequestComplete)completBlock;

@end

