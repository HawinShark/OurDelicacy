//
//  BreakFastViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "BreakFastViewController.h"
#import "DetailsPageController.h"

#import "BreakfastCell.h"

#import "List.h"

#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefreshBackNormalFooter.h>
#import <MJRefresh.h>
@interface BreakFastViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *carouselArray;
    NSMutableArray *cellArray;
    NSMutableArray *pictureArray;
    NSMutableArray *titles;
    
    //轮播图的标题
    NSMutableArray *title;
    NSInteger page;
    
    //数据库
    NSString *makeTitle;
    NSString *imgUrl;
    NSString *VcName;
    NSInteger bookId;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *returnTop;


@end

@implementation BreakFastViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    //异步
    [self showHint:@"正在加载..."];
    [self RequestData];
    

    /* 创建UI*/
    [self buildUI];
    
    __weak typeof(self)loadSelf = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [loadSelf LoadData];

    }];
    
    
    __weak typeof(self)refreshSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [refreshSelf RequestData];
    }];
    
    self.tableView.separatorStyle = NO;//隐藏tableView分割线
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 240;
    
}

#pragma mark- 创建UI

- (void) buildUI
{
    // your code
    
}


#pragma mark- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _DataSource.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *string = @"cell";
    
    BreakfastCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"BreakfastCell" owner:nil options:nil]lastObject];
    
    if (cell == nil) {
        
        cell = [[BreakfastCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
    if (_DataSource.count != 0) {
        
        List *model = [_DataSource objectAtIndex:indexPath.row];
        [cell AcquireModel:model];
    }
    
    if (indexPath.row % 2 == 0) {
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:108/255. green:90/255. blue:70/255. alpha:1]];
    }else{
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:93/255. green:58/255. blue:64/255. alpha:1]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



#pragma mark- tableViewCell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsPageController *DetailsPage = [[DetailsPageController alloc]init];
    
    List *model = _DataSource[indexPath.row];
    DetailsPage.DetailsId = model.listIdentifier;
    
    NSLog(@"model.listIdentifier = %@",model.listIdentifier);
    [self.navigationController pushViewController:DetailsPage animated:YES];
}


#pragma mark- 请求数据
-(void)RequestData{
    
    _DataSource = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([self isNetWork]) {
                        
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            [manager POST:@"http://42.121.253.143/public/getContentsBySubClassid.shtml?id=7136465&page=0&type=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                NSArray *array = [responseObject objectForKey:@"list"];
                
                for (NSDictionary *dic in array) {
                    
                    List *model = [[List alloc]initWithDictionary:dic];
                    
                    [_DataSource addObject:model];
                    
                }
                //主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self showhide];
                    [self.tableView reloadData];
                    [self.tableView.mj_header endRefreshing];
                });
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self showHint:@"数据异常"];
            }];
        }else
        {
            [self showHint:@"网络异常请检测网络"];
        }
    });
    
    
}



#pragma mark- 加载数据
-(void)LoadData{
    
    if ([self isNetWork]) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            [manager POST:[NSString stringWithFormat:@"http://42.121.253.143/public/getContentsBySubClassid.shtml?id=7136465&page=%ld&type=0",++page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                NSArray *array = [responseObject objectForKey:@"list"];
                
                for (NSDictionary *dic in array) {
                    
                    List *model = [[List alloc]initWithDictionary:dic];
                    
                    [_DataSource addObject:model];
                    
                }
                //主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self showhide];
                    [self.tableView reloadData];
                    [self.tableView.mj_footer endRefreshing];
                });
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self showHint:@"数据异常"];
            }];
        });
    }else
    {
        [self showHint:@"网络异常请检测网络"];
    }
        
    
}



#pragma mark- 返回按钮
- (IBAction)returnButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark- 返回顶部按钮
- (IBAction)returnTop:(id)sender {
    NSLog(@"返回顶部");
    [self.tableView setContentOffset:CGPointZero animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//隐藏电池栏
-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.hidesBarsOnSwipe = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


@end
