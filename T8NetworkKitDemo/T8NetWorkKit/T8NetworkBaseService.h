//
//  T8NetworkBaseService.h
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T8NetworkPrivate.h"
#import "T8NetworkError.h"

@class T8NetworkError;
@class T8FileModel;
@class T8FileModelArray;

typedef NS_ENUM(NSInteger, FileModelType) {
    FileModelData,
    FileModelPath
};


typedef void(^RequestComplete)(RequestStatus status, NSDictionary *data, T8NetworkError *error);
typedef void(^RequestProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

@interface T8NetworkBaseService : NSObject

+ (T8NetworkBaseService *)shrareInstance;

/**
 *  根据HTTP方法(GET, POST, DELETE, PUT, PATCH, DELETE)获取数据
 *
 *  @param strUrlPath    接口的地址
 *  @param httpMethod    HTTP方法
 *  @param dictParams    参数
 *  @param completeBlock 回调方法
 */
- (void)sendRequestUrlPath:(NSString *)strUrlPath httpMethod:(HttpMethod)httpMethod dictParams:(NSMutableDictionary *)dictParams completeBlock:(RequestComplete)completeBlock;
/**
 *  上传单个文件
 *
 *  @param fileModel     文件模型
 *  @param strUrlPath    上传接口地址
 *  @param params        参数
 *  @param progressBlock 上传进度回调方法
 *  @param completBlock  上传成功回调方法
 */
- (void)uploadFile:(T8FileModel *)fileModel urlPath:(NSString *)strUrlPath params:(NSMutableDictionary *)params progressBlock:(RequestProgressBlock)progressBlock completeBlock:(RequestComplete)completeBlock;

/**
 *  上传一组文件
 *
 *  @param files         文件模型数据
 *  @param strUrlPath    上传接口地址
 *  @param params        参数
 *  @param progressBlock 上传进度回调方法
 *  @param completBlock  上传完成回调方法
 */
- (void)uploadFiles:(T8FileModelArray *)files urlPath:(NSString *)strUrlPath params:(NSMutableDictionary *)params progressBlock:(RequestProgressBlock)progressBlock completeBlock:(RequestComplete)completeBlock;

@end


/**
 *  文件模型
 */
@interface T8FileModel : NSObject

@property (nonatomic, assign) FileModelType type;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, strong) NSData *data;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, copy) NSString *mimeType;

@end


/**
 *  文件模型数组
 */
@interface T8FileModelArray : NSObject
@property (nonatomic, strong) NSArray<T8FileModel *> *fileModelArray;

@end



