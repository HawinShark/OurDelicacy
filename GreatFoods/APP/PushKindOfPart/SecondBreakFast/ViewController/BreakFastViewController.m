//
//  BreakFastViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "BreakFastViewController.h"
#import "DetailsPageController.h"

#import "carouselCell.h"
#import "IndexSecondCell.h"

#import "List.h"

#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefreshBackNormalFooter.h>

@interface BreakFastViewController () <UITableViewDataSource,UITableViewDelegate,LunBo>
{
    NSMutableArray *carouselArray;
    NSMutableArray *cellArray;
    NSMutableArray *pictureArray;
    NSMutableArray *titles;
    
    //轮播图的标题
    NSMutableArray *title;
    NSInteger page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *returnTop;


@end

@implementation BreakFastViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //异步
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self GetData];
//    });
    
    /* 创建UI*/
    [self buildUI];
    
    __weak typeof(self)mySelf = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
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
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1, screen_width, 31)];
    [image setImage:[UIImage imageNamed:@"section.png"]];
    [view addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screen_width, 31)];
    
    if (titles.count != 0) {
        [label setText:titles[section + 4]];
    }
    
    [label setTextColor:[UIColor whiteColor]];
    
    [image addSubview:label];
    
    return view;
}


#pragma mark- section的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else
        return 30;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 250;
    }
    
    return 200;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_DataSource.count != 0) {
        
        return _DataSource.count - 4;
    }
    return 10;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
    }
    
    if (_DataSource.count != 0) {
        
        return titles[section + 4];
    }
    return NULL;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"carousel";

    if (indexPath.section == 0) {
        carouselCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (cell == nil) {
            cell = [[carouselCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        
        if (title.count != 0) {
            cell.titles = title;
        }
        
        if (carouselArray.count != 0) {
            
            [cell setCarouselArray:carouselArray];
        }
        
        
        cell.delegate = self;
        
        
        return cell;
    }
    else
    {
        IndexSecondCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"IndexSecondCell" owner:nil options:nil] lastObject];
        
        if (cell == nil) {
            cell = [[IndexSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"breakSecond"];
        }
        
        if (_DataSource.count != 0) {
    
            List *model = [_DataSource objectAtIndex:indexPath.section + 4];
            
            [cell Get:model];
            
        }
        
        return cell;
    }
}

-(void)infiniteScrollViewdidSelectItemAtIndex:(NSInteger)index
{
    DetailsPageController *DetailsPage = [[DetailsPageController alloc]init];
    
    List *model = _DataSource[index];
    DetailsPage.DetailsId = model.listIdentifier;
    
    NSLog(@"model.listIdentifier = %@",model.listIdentifier);
    [self.navigationController pushViewController:DetailsPage animated:YES];

}

#pragma mark- tableViewCell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsPageController *DetailsPage = [[DetailsPageController alloc]init];
    
    List *model = _DataSource[indexPath.section + 4];
    DetailsPage.DetailsId = model.listIdentifier;
    
    NSLog(@"model.listIdentifier = %@",model.listIdentifier);
    [self.navigationController pushViewController:DetailsPage animated:YES];
}


#pragma mark- 下拉加载数据
- (void)LoadData
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"http://42.121.253.143/public/getContentsBySubClassid.shtml?id=7136465&page=%ld&type=0",++page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [responseObject objectForKey:@"list"];
        
        for (NSDictionary *dic in array) {
            
            List *model = [[List alloc]initWithDictionary:dic];
            
            [titles addObject:model.name];
            
            
            [_DataSource addObject:model];
        }
        
        
        //主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        });
        
    } failure:nil];
    
}



#pragma mark- 异步获取数据
- (void)GetData{

    _DataSource = [NSMutableArray array];
    carouselArray = [NSMutableArray array];
    titles = [NSMutableArray array];
    title = [NSMutableArray array];
    
    if ([self isNetWork]) {
        
        [self showHint:@"正在加载..."];
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:@"http://42.121.253.143/public/getContentsBySubClassid.shtml?id=7136465&page=0&type=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self showhide];
            
            NSArray *array = [responseObject objectForKey:@"list"];
            
            for (NSDictionary *dic in array) {
                
                List *model = [[List alloc]initWithDictionary:dic];
                
                [titles addObject:model.name];
                
                [carouselArray addObject:model.imageid];
                
                [_DataSource addObject:model];
                
                [title addObject:model.name];
            }
            //主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
            
                [self.tableView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showHint:@"数据异常"];
        }];
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



-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}


@end
