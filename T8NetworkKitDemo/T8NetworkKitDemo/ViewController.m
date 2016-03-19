//
//  ViewController.m
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import "ViewController.h"
#import "T8NetworkBaseService.h"
#import "DemoService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testPost];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)testPost
{
    [DemoService testRequestWithId:@"3704212316" secret:@"1c5cd4c8a41fa09faedeead805a66717" type:@"authorization_code" code:@"b07fd2f79d0edd738df59b6c50d542b8" uri:@"http://login.zhongsou.com" block:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
        NSLog(@"%@", data);
    }];
}

- (void)testGet
{
    [T8NetworkBaseService setBaseUrl:@"http://api-saas-dev.tinfinite.com"];
    [T8NetworkBaseService setHandleBlock:^(NSMutableURLRequest *request) {
        [request setValue:@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNTZlNjdjYjc3ZTJjYzI4YTIxYjg5MzI3IiwiZGV2aWNlX2lkIjoiRTQ1RTIyQkMtQUYxMC00RTI2LUJDOUYtQUI5OEFFNzE4RDQ0IiwidHMiOjE0NTgyODgxMTc1MTMsImFwcF9pZCI6IjU2YzZjMzA5MjQzY2I3MjgyMDVhM2RmZiIsImlhdCI6MTQ1ODI4ODExN30.v4Sex80uTUVN7htZz-LoDuaqHLFmtPlzcZ5jxGHXUzI" forHTTPHeaderField:@"x-access-token"];
        [request setValue:@"ewogICJwaG9uZV9tb2RlbCIgOiAiaVBob25lIiwKICAicmVsZWFzZV9jaGFubmVsIiA6ICJhcHBfc3RvcmUiLAogICJhcHBfdmVyc2lvbiIgOiAiMTAwIiwKICAib3NfdmVyc2lvbiIgOiAiOS4yLjEiLAogICJkZXZpY2VfdG9rZW4iIDogIjZjNGI2NGQ5ZDgzYTVlNjY0ZDg3N2EwNTRhODMzZWNiMzg4MmQyOWVlYTdmZWNkZTE2YWEzMGFkMzQ3MzEzYTgiLAogICJwbGF0Zm9ybSIgOiAiaU9TIgp9" forHTTPHeaderField:@"x-device-info"];
        [request setValue:@"56c6c309243cb728205a3dff" forHTTPHeaderField:@"x-app-id"];
    }];

    [DemoService testRequestWithLimit:20 last:nil block:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
        NSLog(@"tt:%@", data);
    }];

}
@end
