//
//  T8NetworkConifig.h
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/22.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^RequestHeaderBlock)(NSMutableURLRequest *request);

@protocol T8UrlFilterProtocol <NSObject>
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(NSMutableURLRequest *)request;
@end


@interface T8NetworkConifig : NSObject

+ (T8NetworkConifig *)sharedInstance;

@property (nonatomic, copy) NSString *baseUrl;

@property (nonatomic, copy) RequestHeaderBlock headerBlock;

@property (strong, nonatomic, readonly) NSArray *urlFilters;

/**
 *  设置header参数
 */
- (void)setHeaderBlock:(RequestHeaderBlock)headerBlock;

- (void)addUrlFilter:(id<T8UrlFilterProtocol>)filter;

@end
