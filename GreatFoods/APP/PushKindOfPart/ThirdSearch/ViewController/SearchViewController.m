//
//  SearchViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/20.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomSearchBar.h"

@interface SearchViewController ()
<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)UISearchController *searchController;

@property(nonatomic,retain)NSMutableArray *dataList;
@property(nonatomic,retain)NSMutableArray *searchList;


@end

@implementation SearchViewController

#pragma mark- 懒加载搜索数据
-(NSMutableArray *)searchList{
    if (!_searchList) {
        _searchList = [NSMutableArray new];
    }
    return _searchList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    self.dataList   = [NSMutableArray new];

    
    [self buildCustomSearch];
    
//    [self buildSearch];
}











#pragma mark- 创建自定义search

- (void) buildCustomSearch
{
    //image
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_width * (3.0/4.0))];
    image.contentMode  = UIViewContentModeScaleAspectFill;
    [image setImage:[UIImage imageNamed:@"background-6"]];
    [self.view addSubview:image];
    
    //search
    CustomSearchBar *search = [[CustomSearchBar alloc]initWithFrame:CGRectMake(40, screen_width * 0.55, screen_width - 80, 40)];
    [search getBlockFromOutSpace:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    [self.view addSubview:search];
}












#pragma mark- 创建搜索

-(void)buildSearch{
    self.tableView            = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.rowHeight = 80;
    self.tableView.bounces = NO;
    self.tableView.alpha = 0;
    
#pragma mark- 创建搜索框
    self.searchController                      = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.delegate             = self;
    self.searchController.searchResultsUpdater = self;//代理
    
    //搜索时候背景变暗
    self.searchController.dimsBackgroundDuringPresentation     = YES;
    //搜索时模糊
    self.searchController.obscuresBackgroundDuringPresentation = YES;
    //隐藏导航栏
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    self.definesPresentationContext = YES;
//    
    self.searchController.searchBar.frame = CGRectMake(0, 0, screen_width, 44.0);;
    self.searchController.searchBar.alpha = 0;
    
//    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchController.searchBar];
}



#pragma mark- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active)
    {
        return self.searchList.count;
    }else{
        return self.dataList.count;
    }
}




#pragma mark- tableviewCell

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellid      = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    //
    if (self.searchController.active)
    {
//        cell.textLabel.text = self.searchList[indexPath.row];
    }else{
//        cell.textLabel.text = self.dataList[indexPath.row];
    }
    
    return cell;
}







#pragma mark- 更新数据

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"updateSearchResultsForSearchController");
    
    NSString *searchStr = self.searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchStr];
    if (self.searchList != nil) {
        [self.searchList removeAllObjects];
    }
    
    //过滤数据
    self.searchList = [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:predicate]];
    [self.tableView reloadData];
}








#pragma mark - UISearchControllerDelegate代理

//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}






#pragma mark- 移除视图
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
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
