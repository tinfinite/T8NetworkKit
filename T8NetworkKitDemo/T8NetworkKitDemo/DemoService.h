//
//  DemoService.h
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T8NetworkBaseService.h"

@interface DemoService : NSObject

+ (void)testRequestWithLimit:(NSInteger)limit last:(NSString *)last block:(RequestComplete)requestComplete;
+ (void)testRequestWithId:(NSString *)id secret:(NSString *)secret type:(NSString *)type code:(NSString *)code uri:(NSString *)uri block:(RequestComplete)requestComplete;
@end
