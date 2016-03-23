//
//  T8NetworkConifig.m
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/22.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import "T8NetworkConifig.h"

@implementation T8NetworkConifig {
    NSMutableArray *_urlFilters;
}

+ (T8NetworkConifig *)sharedInstance {
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
        _urlFilters = [NSMutableArray array];
    }
    return self;
}

- (void)setHeaderBlock:(RequestHeaderBlock)headerBlock
{
    _headerBlock = headerBlock;
}

- (void)addUrlFilter:(id<T8UrlFilterProtocol>)filter
{
    [_urlFilters addObject:filter];
}

- (NSArray *)urlFilters {
    return [_urlFilters copy];
}

@end
