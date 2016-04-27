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


+ (DataBase *)shareData;


- (void) openFmdb;
- (void) insertInfo:(CollectModel *)model;
- (void) deleteInfo:(id)makeTitle;
- (NSMutableArray *)queryMakeTitle;
- (NSMutableArray *)queryCollectModel;




#pragma mark- 表2

//创建一个表
-(BOOL)creatAndOpenTable;
//添加
-(void)insertPeople:(CollectModel *)model;

//查询
-(NSMutableArray *)selectMovie;
//删除
-(void)deletePeopleWithMakeTitle:(NSString *)makeTime;

@end
