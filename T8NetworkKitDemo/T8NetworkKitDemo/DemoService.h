//
//  DemoService.h
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T8NetworkBaseService.h"

@class PostParams;
@class GetParams;

@interface DemoService : NSObject

+ (void)testRequestWithGetParmas:(GetParams *)getParams block:(RequestComplete)requestComplete;
+ (void)testRequestWithPostParams:(PostParams *)postParams block:(RequestComplete)requestComplete;

@end
