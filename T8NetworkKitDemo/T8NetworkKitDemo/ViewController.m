//
//  ViewController.m
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/19.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import "ViewController.h"
#import "T8NetworkBaseService.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "DemoService.h"
#import "PostParams.h"
#import "GetParams.h"
#import "T8NetworkConifig.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    T8NetworkConifig *config = [T8NetworkConifig sharedInstance];
    config.baseUrl = @"http://api-saas-dev.tinfinite.com";
    [config setHeaderBlock:^(NSMutableURLRequest *request) {
        [request setValue:@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNTZlNjdjYjc3ZTJjYzI4YTIxYjg5MzI3IiwiZGV2aWNlX2lkIjoiRTQ1RTIyQkMtQUYxMC00RTI2LUJDOUYtQUI5OEFFNzE4RDQ0IiwidHMiOjE0NTgyODgxMTc1MTMsImFwcF9pZCI6IjU2YzZjMzA5MjQzY2I3MjgyMDVhM2RmZiIsImlhdCI6MTQ1ODI4ODExN30.v4Sex80uTUVN7htZz-LoDuaqHLFmtPlzcZ5jxGHXUzI" forHTTPHeaderField:@"x-access-token"];
        [request setValue:@"ewogICJwaG9uZV9tb2RlbCIgOiAiaVBob25lIiwKICAicmVsZWFzZV9jaGFubmVsIiA6ICJhcHBfc3RvcmUiLAogICJhcHBfdmVyc2lvbiIgOiAiMTAwIiwKICAib3NfdmVyc2lvbiIgOiAiOS4yLjEiLAogICJkZXZpY2VfdG9rZW4iIDogIjZjNGI2NGQ5ZDgzYTVlNjY0ZDg3N2EwNTRhODMzZWNiMzg4MmQyOWVlYTdmZWNkZTE2YWEzMGFkMzQ3MzEzYTgiLAogICJwbGF0Zm9ybSIgOiAiaU9TIgp9" forHTTPHeaderField:@"x-device-info"];
        [request setValue:@"56c6c309243cb728205a3dff" forHTTPHeaderField:@"x-app-id"];
    }];
    
//    [self testFilesUpload];
//    [self testUpload];
    [self testGet];
//    [self testJson2Model];
}

- (void)testPost
{
    PostParams *params = [[PostParams alloc]init];
    params.client_id = @"3704212316";
    params.client_secret = @"1c5cd4c8a41fa09faedeead805a66717";
    params.grant_type = @"authorization_code";
    params.code = @"b07fd2f79d0edd738df59b6c50d542b8";
    params.redirect_uri = @"http://login.zhongsou.com";
    
    [DemoService testRequestWithPostParams:params block:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
        NSLog(@"%@", data);
    }];
}

- (void)testGet
{
    GetParams *getParam = [[GetParams alloc]init];
    [DemoService testRequestWithGetParmas:getParam block:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
        NSLog(@"%@", data);
    }];
}

- (void)testUpload
{
    
    UIImage *image = [UIImage imageNamed:@"bcd"];
    if (image) {
        NSLog(@"image not nil");
    }
    NSData *data = UIImageJPEGRepresentation(image, 1);
    T8FileModel *fileModel = [[T8FileModel alloc]init];
    fileModel.data = data;
    fileModel.type = FileModelData;
    fileModel.mimeType =@"image/jpg";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"abc" ofType:@"jpg"] ;
    fileModel.path = filePath;
    UIImage *image1 = [UIImage imageWithContentsOfFile:fileModel.path];
    if (image1) {
        NSLog(@"image1 is not nil");
    }
    fileModel.name = @"file";
    fileModel.fileName = @"abc.jpg";

    [DemoService testUploads:fileModel block:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
    }];
}

- (void)testFilesUpload
{
    UIImage *image = [UIImage imageNamed:@"bcd"];
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"abc" ofType:@"jpg"] ;
    NSLog(@"%@", filePath);
    T8FileModel *fileModel1 = [[T8FileModel alloc]init];
    T8FileModel *fileModel2 = [[T8FileModel alloc]init];
    T8FileModel *fileModel3 = [[T8FileModel alloc]init];

    
    fileModel1.data = data;
    fileModel1.type = FileModelData;
    fileModel1.mimeType =@"image/jpg";
    fileModel1.path = filePath;
    fileModel1.name = @"file1d";
    fileModel1.fileName = @"abc.jpg";
    
    fileModel2.data = data;
    fileModel2.type = FileModelData;
    fileModel2.mimeType =@"image/jpg";
    fileModel2.path = filePath;
    fileModel2.name = @"filedd";
    fileModel2.fileName = @"bcd.jpg";
    
    fileModel3.data = data;
    fileModel3.type = FileModelPath;
    fileModel3.mimeType =@"image/jpg";
    fileModel3.path = filePath;
    fileModel3.name = @"filebb";
    fileModel3.fileName = @"cde.jpg";

    
    T8FileModelArray *fileModelArray = [[T8FileModelArray alloc]init];
    fileModelArray.fileModelArray = @[fileModel1, fileModel2, fileModel3];
    
    [DemoService testFilesUploads:fileModelArray block:^(RequestStatus status, NSDictionary *data, T8NetworkError *error) {
    }];
}

- (void)testJson2Model
{
    NSArray *array = @[@{@"name":@"a", @"age":@12},@{@"name":@"b", @"age":@4}];
    NSDictionary *dict = @{
                           @"list":array,
                           @"status":@2,
                           @"id":@"12"
                           };
    FriendsModel *models = [FriendsModel mj_objectWithKeyValues:dict];

    NSLog(@"%@", models.list[1]);
    NSLog(@"%ld", models.status);
    NSLog(@"%@", models.id);
}

@end
