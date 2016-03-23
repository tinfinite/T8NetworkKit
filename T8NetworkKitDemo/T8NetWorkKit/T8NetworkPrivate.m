//
//  T8NetworkPrivate.m
//  T8NetworkKitDemo
//
//  Created by Ryeagler on 16/3/23.
//  Copyright © 2016年 Ryeagle. All rights reserved.
//

#import "T8NetworkPrivate.h"

@implementation T8NetworkPrivate

+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters {
    NSMutableString *urlParametersString = [[NSMutableString alloc] initWithString:@""];
    if (parameters && parameters.count > 0) {
        for (NSString *key in parameters) {
            NSString *value = parameters[key];
            value = [NSString stringWithFormat:@"%@",value];
            value = [self urlEncode:value];
            [urlParametersString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlParametersString;
}


+ (NSString*)urlEncode:(NSString*)str {
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];

    NSString *result = [str stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    return result;
}

+ (NSString *)getMethodTypeString:(HttpMethod)httpMethod{
    NSString *method = nil;
    switch(httpMethod) {
        case HttpMethodGet:
            method = @"GET";
            break;
        case HttpMethodPost:
            method = @"POST";
            break;
        case HttpMethodPut:
            method = @"PUT";
            break;
        case HttpMethodDelete:
            method = @"DELETE";
            break;
        case HttpMethodPatch:
            method = @"PATCH";
            break;
        case HttpMethodHead:
            method = @"HEAD";
            break;
        default:
            break;
    }
    return method;
}


+ (NSString *)buildRequestUrl:(NSString *)baseUrl detailUrl:(NSString *)detailUrl
{
    if ([detailUrl hasPrefix:@"http"]) {
        return detailUrl;
    }
    
    if (baseUrl.length>0) {
        return [NSString stringWithFormat:@"%@/%@", baseUrl, detailUrl];
    }else{
        return detailUrl;
    }
}



@end
