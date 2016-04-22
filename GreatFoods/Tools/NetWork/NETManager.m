//
//  NETManager.m
//  健康菜谱
//
//  Created by 夏浩文 on 16/4/11.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "NETManager.h"
#import <AFNetworking.h>
@implementation NETManager

+ (NETManager *)initRequestHttpURL:(NSString *)httpUrl WithHttpARG:(NSString *)httpArg ForYourHeaderKey:(NSString *)HeaderKey WithHeaderField:(NSString *)headerField
{
    NETManager *manager = [[NETManager alloc]initRequestHttpURL:httpUrl WithHttpARG:httpArg ForYourHeaderKey:HeaderKey WithHeaderField:headerField];
    return manager;
}

- (instancetype)initRequestHttpURL:(NSString *)httpUrl WithHttpARG:(NSString *)httpArg ForYourHeaderKey:(NSString *)HeaderKey WithHeaderField:(NSString *)headerField;
{
    self = [super init];
    if (self) {
        [self request:httpUrl withHttpArg:httpArg ForYourHeaderKey:HeaderKey WithHeaderField:headerField];
    }
    return self;
}

- (void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg ForYourHeaderKey:(NSString *)HeaderKey WithHeaderField:(NSString *)headerField {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    urlStr           = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//转utf8-之前的被替换成这个了
    NSURL *url       = [NSURL URLWithString: urlStr];
    
    //af
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:HeaderKey forHTTPHeaderField:headerField];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.SendDataBack(responseObject);
            //                self.ReloadData();
        });
    } failure:nil];
    
//        [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            /**延迟执行**
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    
//                });
//            **/
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.SendDataBack(responseObject);
//    //                self.ReloadData();
//                });
//            }failure:nil];
}

@end
