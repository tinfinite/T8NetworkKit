//
//  T8NetworkError.h
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestStatus)
{
    RequestStatusSuccess,
    RequestStatusFailure
};

@interface T8NetworkError : NSError
/**
 * 返回由NSError构建的错误对象.
 */
+ (T8NetworkError*)errorWithNSError:(NSError*)error;

/**
 * 构造错误对象。
 *
 * @param code 错误代码
 * @param errorMessage 错误信息
 *
 * 返回错误对象.
 */
+ (T8NetworkError*)errorWithCode:(NSInteger)code errorMessage:(NSString*)errorMessage;

/**
 * 返回用于展现给用户的错误提示标题
 */
- (NSString*)titleForError;

@end
