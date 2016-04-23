//
//  BreakFastViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "BreakFastViewController.h"
#import "IndexSecondCell.h"

#import "List.h"

#import <AFNetworking.h>
#import <MJRefreshBackNormalFooter.h>
//#import <>


@interface BreakFastViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *titles;
    NSInteger page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation BreakFastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self GetData];
    });
    
    /* 创建UI*/
    [self buildUI];
    
    __weak typeof(self)mySelf = self;
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [mySelf LoadData];
    }];
}


//隐藏电池栏
-(BOOL)prefersStatusBarHidden {
    return YES;
}



#pragma mark- 创建UI

- (void) buildUI
{
    // your code
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 200;    //估高
    
    
    
}



#pragma mark- tableviewDatasource



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titles.count;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
      
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return NULL;
}












#pragma mark- tableviewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}















#pragma mark- 下拉加载数据
- (void)LoadData
{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"http://42.121.253.143/public/getContentsBySubClassid.shtml?id=7136465&page=%ld&type=0",page++] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        //主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        });
        
    } failure:nil];
    

}







#pragma mark- 异步获取数据
- (void)GetData{

    
    titles = [NSMutableArray array];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:@"http://42.121.253.143/public/getContentsBySubClassid.shtml?id=7136465&page=0&type=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *array = [responseObject objectForKey:@"list"];
        
        
        
        
        //主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
    } failure:nil];
    
}




- (IBAction)returnButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
