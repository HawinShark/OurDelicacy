//
//  SearchNextViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "SearchNextViewController.h"
#import "searchCell.h"

#import "SearchData.h"
#import <AFNetworking.h>

@interface SearchNextViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,retain) NSMutableArray *dataSource;

@end

@implementation SearchNextViewController





- (void)viewWillAppear:(BOOL)animated
{
    self.title = self.name;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Zapfino" size:15.0] forKey:NSFontAttributeName]];
    
    self.navigationController.navigationBarHidden = NO;
}







- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    if (IOS_VERSION >= 7) {
        
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    
    
    self.tableView.rowHeight = 170;
    
    [self buildTransluent];
    
    
    /* 数据源 */
    [self showHudInViewhint:@"努力加载中.."];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self getdata];
    });
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(Back)];
}


- (void)Back{
    [self dismissViewControllerAnimated:YES completion:nil];
}








-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}






#pragma mark- tableview delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    return cell;
}














#pragma mark- data

- (void) getdata
{
    _dataSource = [NSMutableArray new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *utf = [self.name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *urlstr = [NSString stringWithFormat:@"http://218.244.151.213/daydaycook/server/recipe/search.do?name=%@&pageSize=20&currentPage=0",utf];
    
    [manager POST:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
            [self showHint:@"请求失败"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        
    } failure:nil];
    
}


- (void)getNewData
{
    
}








#pragma mark- build transluent

- (void)buildTransluent
{
    UIView *alphaView = [[UIView alloc] initWithFrame:self.view.frame];
    UIView *baseView  = [[UIView alloc] initWithFrame:self.view.frame];
    
    alphaView.backgroundColor = [UIColor clearColor];
    baseView.backgroundColor  = [UIColor blackColor];
    
    baseView.alpha = 0.7;
    
    [self.view addSubview:baseView];
    [self.view addSubview:alphaView];
    
    [self.view sendSubviewToBack:baseView];
    [self.view sendSubviewToBack:alphaView];
    
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
