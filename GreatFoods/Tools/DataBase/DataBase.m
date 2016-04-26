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


+(DataBase *)shareData
{
    static DataBase *dataBase= nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        dataBase = [[DataBase alloc]init];
        
    });
    return dataBase;
}
-(void)openFmdb
{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"collect.sqlite"];
    NSLog(@"```````%@",doc);
    //2.获得数据库
    self.db=[FMDatabase databaseWithPath:fileName];
    
    //3.打开数据库
    if ([self.db open]) {
        //4.创表
        BOOL result=[self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collect (id integer PRIMARY KEY AUTOINCREMENT,  imgUrl text,bookId integer,makeTitle text );"];
        
        
        if (result) {
            NSLog(@"创表成功");
        }else
        {
            NSLog(@"创表失败");
        }
    }
    
    
}

-(void)insertInfo:(CollectModel *)model
{
    [self.db executeUpdate:@"INSERT INTO t_collect (imgUrl,bookId,makeTitle) VALUES(?,?,?);",model.imgUrl,@(model.bookId),model.makeTitle];
    
}
- (NSMutableArray *)queryMakeTitle
{   // 1.执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_collect"];
    // 2.遍历结果
    NSMutableArray *array = [[NSMutableArray alloc ]init];
    
    
    
    while ([resultSet next]) {
       
        NSString *makeTitle = [resultSet stringForColumn:@"makeTitle"];
        if (makeTitle) {
            [array addObject:makeTitle];

        }
        
    }

    NSLog(@"array===%@",array);
    
    return array;
}
- (NSMutableArray *)queryCollectModel{
    
    // 1.执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_collect"];
    // 2.遍历结果
    NSMutableArray *array = [[NSMutableArray alloc ]init];
    
    
    
    while ([resultSet next]) {
        
        NSString *makeTitle = [resultSet stringForColumn:@"makeTitle"];
        NSString *imgUrl = [resultSet stringForColumn:@"imgUrl"];
        NSInteger bookId = [resultSet intForColumn:@"bookId"];
        CollectModel *model = [[CollectModel alloc]init];
        model.imgUrl = imgUrl;
        model.bookId = bookId;
        model.makeTitle = makeTitle;
            [array addObject:model];
            
        
    }
    
    
    return array;
    
}

- (void) deleteInfo:(id)makeTitle
{

    
    if ([self.db open]) {
        NSString *str = [NSString stringWithFormat:@"delete from t_collect where makeTitle = '%@'",makeTitle];
        BOOL result = [self.db executeUpdate:str];
        
        if (result) {
            NSLog(@"delete成功");
        }
    }

}


@end
