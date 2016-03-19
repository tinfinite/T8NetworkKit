//
//  PostParams.h
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostParams : NSObject

@property (nonatomic, copy) NSString *client_id;
@property (nonatomic, copy) NSString *client_secret;
@property (nonatomic, copy) NSString *grant_type;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *redirect_uri;

@end
