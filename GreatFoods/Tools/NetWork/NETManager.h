//
//  NETManager.h
//  健康菜谱
//
//  Created by 夏浩文 on 16/4/11.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NETManager : NSObject

/*reload数据时调用*/
@property(nonatomic,copy) void (^ReloadData)();
/*获取返回的数据*/
@property(nonatomic,copy) void (^SendDataBack)(id);

#pragma mark- 便利构造器
/*URL + dic内容 + YourAPPID(接口id) + headerField(@"apikey")*/
+ (NETManager *)initRequestHttpURL:(NSString *)httpUrl
                       WithHttpARG:(NSString *)httpArg
                  ForYourHeaderKey:(NSString *)HeaderKey
                   WithHeaderField:(NSString *)headerField;
@end
