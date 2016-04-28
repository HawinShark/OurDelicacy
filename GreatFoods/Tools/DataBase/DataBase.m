
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
@property(nonatomic,strong)FMDatabase *database;
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
    //2.获得数据库
    self.db = [FMDatabase databaseWithPath:fileName];
    
    //3.打开数据库
    if ([self.db open]) {
        //4.创表
        BOOL result=[self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collect (id integer PRIMARY KEY AUTOINCREMENT,  imgUrl text,bookId integer,makeTitle text)"];
        
        
        if (result) {
//            NSLog(@"创表成功");
        }else
        {
//            NSLog(@"创表失败");
        }

    }
    
    
}

-(void)insertInfo:(CollectModel *)model
{
    [self.db open];
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

//    NSLog(@"array===%@",array);
    
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
            
        NSLog(@"表1 - > %@ -> %ld",makeTitle,(long)model.bookId);
        
    }

//    NSLog(@"array===%@",array);
    
    return array;
    
}

- (void) deleteInfo:(id)makeTitle
{

    
    if ([self.db open]) {
        NSString *str = [NSString stringWithFormat:@"delete from t_collect where makeTitle = '%@'",makeTitle];
        BOOL result = [self.db executeUpdate:str];
        
        if (result) {
            [self.db close];
//            NSLog(@"delete成功");
        }
    }

}




#pragma mark- 表2

-(BOOL)creatAndOpenTable
{
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",docPath);
    
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"person.sqlite"];
    
    //创建数据库
    _database = [FMDatabase databaseWithPath:dbPath];
    
    //打开数据
    [_database open];
    
    //创建表
    BOOL result = [self.database executeUpdate:
                   @"CREATE TABLE IF NOT EXISTS h_collect (id integer PRIMARY KEY AUTOINCREMENT,  imgUrl text,bookId integer,makeTitle text );"];
    
    if (result)
    {
//        NSLog(@"创建表成功");
    }
    return result;
}

-(void)insertPeople:(CollectModel *)model
{
    [self.database open];
        //添加用户
        //执行添加语句
        BOOL result = [self.database executeUpdate:@"INSERT INTO h_collect (imgUrl,bookId,makeTitle) VALUES(?,?,?);",model.imgUrl,@(model.bookId),model.makeTitle];
        
        if (result) {
            NSLog(@"2表add成功");
        }
}

-(void)deletePeopleWithMakeTitle:(NSString *)makeTime
{
    if ([self.database open]) {
        
        NSString *str = [NSString stringWithFormat:@"delete from h_collect where makeTitle = '%@'",makeTime];
        BOOL result = [self.database executeUpdate:str];
        
        if (result) {
//            NSLog(@"delete成功");
            [self.database close];
        }

    }
}


-(NSMutableArray *)selectMovie
{
    [self.database open];
        
        // 1.执行查询语句
        FMResultSet *resultSet = [self.database executeQuery:@"SELECT * FROM h_collect"];
        NSMutableArray *array = [NSMutableArray new];

        //获取数据
        while ([resultSet next]) {

            CollectModel *model = [CollectModel new];
            
            model.imgUrl    = [resultSet stringForColumn:@"imgUrl"];
            model.bookId    = [resultSet intForColumn:@"bookId"];
            model.makeTitle = [resultSet stringForColumn:@"makeTitle"];
            [array addObject:model];
            
            NSLog(@"%@",model.makeTitle);
        }
        
    
    NSMutableArray *reverseArray = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator]allObjects]];
    NSLog(@"获取成功 -> %@",reverseArray);
    
    return reverseArray;
}

-(void)delectALL{
    [self creatAndOpenTable];
    [self.database executeUpdate:@"delete from h_collect"];
    [self.database close];
}


-(void)dealloc{
    [self.db close];
    [self.database close];
}


@end
