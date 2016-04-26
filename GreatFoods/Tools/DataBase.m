//
//  DataBase.m
//  美食类
//
//  Created by lynsea on 16/4/25.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "DataBase.h"
#import "CollectModel.h"

@interface DataBase ()
@property(nonatomic,strong)FMDatabase *db;

@end
@implementation DataBase

+(void)shareData{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"collect.sqlite"];
    NSLog(@"%@",doc);
    //2.获得数据库
    FMDatabase *db=[FMDatabase databaseWithPath:fileName];
    
    //3.打开数据库
    if ([db open]) {
        //4.创表
        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collect (id integer PRIMARY KEY AUTOINCREMENT,  imgUrl text,url text,makeTitle text );"];
        
        
        if (result) {
            NSLog(@"创表成功");
        }else
        {
            NSLog(@"创表失败");
        }
    }
    
}

+(void)insertInfo:(CollectModel *)model
{
    [self shareData];
    
    
    
}
    
    

@end
