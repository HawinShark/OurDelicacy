//
//  DataBase.h
//  美食类
//
//  Created by lynsea on 16/4/25.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDatabaseAdditions.h>
@class CollectModel;
@interface DataBase : NSObject
+(void)shareData;
+(void)insertInfo:(CollectModel *)model;
@end
