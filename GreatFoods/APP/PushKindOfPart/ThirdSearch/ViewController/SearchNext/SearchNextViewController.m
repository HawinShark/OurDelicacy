//
//  SearchNextViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "SearchNextViewController.h"
#import "searchCell.h"
#import "DaydayCookDescription.h"

#import "SearchData.h"
#import <AFNetworking.h>
#import <MJRefreshBackNormalFooter.h>
@interface SearchNextViewController ()
<UITableViewDelegate,UITableViewDataSource>

{
    NSInteger refreshCount;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,retain) NSMutableArray *dataSource;

@end

@implementation SearchNextViewController







- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = self.name;
    
//    [self buildTransluent]; //半透明
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Zapfino" size:15.0] forKey:NSFontAttributeName]];
    
    self.navigationController.navigationBarHidden = NO;
}










- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    /* 数据源 */
    [self showHudInViewhint:@"努力加载中.."];
    
    
        [self getdata];
    
    
    if (IOS_VERSION >= 7) {
        
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        self.automaticallyAdjustsScrollViewInsets = NO;

    }
    
    
    self.tableView.rowHeight = 150;
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(Back)];
    
    //上拉刷新
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getNewData];
    }];
    
}


- (void)Back{
    [self dismissViewControllerAnimated:YES completion:nil];
}











-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}













#pragma mark- tableview delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //滑到中间
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    
    DaydayCookDescription *vc = [DaydayCookDescription new];
    
    vc.isNavigation = YES;
    
    SearchData *model = self.dataSource[indexPath.row];
    
    vc.BookID = model.dataIdentifier;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}




















#pragma mark- tableview datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_dataSource.count > 0) {
        return _dataSource.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    searchCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"searchCell" owner:self options:nil] lastObject];
    if (!cell) {
        cell = [[searchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchCell"];
    }
    
    if (_dataSource.count != 0) {
        
        SearchData *model = self.dataSource[indexPath.row];
        
        [cell setModel:model];
    }
    
    cell.contentView.backgroundColor = RGBA(0, 0, 0, 0);
    
    return cell;
}














#pragma mark- data

- (void) getdata
{
    _dataSource = [NSMutableArray new];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        
        NSString *urlstr = [NSString stringWithFormat:@"http://218.244.151.213/daydaycook/server/recipe/search.do?name=%@&pageSize=20&currentPage=0&parentId=",self.name];
        
        NSString *utf = [urlstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        [manager POST:utf parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //        NSLog(@"%@",responseObject);
            
            if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
                
                NSArray *data = responseObject[@"data"];
                
                for (NSDictionary *dic in data) {
                    
                    SearchData *model = [SearchData modelObjectWithDictionary:dic];
                    [_dataSource addObject:model];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                    [self showhide];
                });
            }
            else{
                [self showHint:responseObject[@"msg"]];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            
        } failure:nil];
    });
    
    
}


- (void)getNewData
{
    refreshCount++;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        
        NSString *urlstr = [NSString stringWithFormat:@"http://218.244.151.213/daydaycook/server/recipe/search.do?name=%@&pageSize=20&currentPage=%ld&parentId=",self.name,refreshCount];
        
        NSString *utf = [urlstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        [manager POST:utf parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //        NSLog(@"%@",responseObject);
            
            if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
                
                NSArray *data = responseObject[@"data"];
                
                for (NSDictionary *dic in data) {
                    
                    SearchData *model = [SearchData modelObjectWithDictionary:dic];
                    [_dataSource addObject:model];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                    [self.tableView.mj_footer endRefreshing];
                });
            }
            else{
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            
        } failure:nil];
    });
    
}








#pragma mark- build transluent

- (void)buildTransluent
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.view.frame];
    UIView *baseView  = [[UIView alloc] initWithFrame:self.view.frame];
    
    alphaView.backgroundColor = [UIColor clearColor];
    baseView.backgroundColor  = [UIColor blackColor];
    
    baseView.alpha = 0.7;
    
    [self.view addSubview:baseView];
    [self.view addSubview:alphaView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
