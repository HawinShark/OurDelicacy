//
//  DetailsPageController.m
//  早餐
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import "DetailsPageController.h"

#import "HeadViewModel.h"
#import "MaterialModel.h"
#import "StepOneModel.h"

#import "HeadViewCell.h"
#import "MaterialCell.h"
#import "StepOneCell.h"

#import "UIImageView+WebCache.h"
#import <AFNetworking.h>
#import <UITableView+SDAutoTableViewCellHeight.h>
@interface DetailsPageController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *array;
    NSMutableArray *array1;
    NSMutableArray *headViewArray;
    NSMutableArray *materialArray;
    NSMutableArray *materislName;
    NSMutableArray *materislNum;
    NSMutableArray *stepArray;
    NSMutableDictionary *dic;
}
@property (weak, nonatomic) IBOutlet UITableView *detailsPageTableView;
@end

@implementation DetailsPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    array = [NSMutableArray new];
    array1 = [NSMutableArray new];
    headViewArray = [NSMutableArray new];
    materialArray = [NSMutableArray new];
    materislName = [NSMutableArray new];
    materislNum = [NSMutableArray new];
    stepArray = [NSMutableArray new];
    dic = [NSMutableDictionary new];
    
    self.detailsPageTableView.rowHeight = UITableViewAutomaticDimension;
    self.detailsPageTableView.estimatedRowHeight = 200;
    
    [self RequestsData];
    
    _detailsPageTableView.delegate = self;
    _detailsPageTableView.dataSource = self;
}


#pragma mark- 网络请求
-(void)RequestsData
{
    
    if ([self isNetWork]) {
        
        [self showHudInViewhint:@"正在加载..."];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:[NSString stringWithFormat:@"http://42.121.253.143/public/getRecipeListByIds.shtml?ids=%@",_DetailsId] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self showhide];
            
            dic = [responseObject objectForKey:@"list"];
            
            //获取头视图数据
            for (NSDictionary *dic2 in dic) {
                HeadViewModel *model = [[HeadViewModel alloc]initWithdic:dic2];
                [headViewArray addObject:model];
            }
            
            //获取食材数据
            for (NSDictionary *dic3 in dic) {
                NSArray *arr = [dic3 objectForKey:@"materialList"];
                
                for (NSDictionary *dic6 in arr) {
                    MaterialModel *model = [[MaterialModel alloc]initWithdic:dic6];
                    [materialArray addObject:model];
                    
                }
            }
            //获取烹饪步骤数据
            for (NSDictionary *dic4 in dic){
                NSArray *arr = [dic4 objectForKey:@"stepList"];
                
                for (NSDictionary *dic5 in arr){
                    
                    StepOneModel *model = [[StepOneModel alloc]initWithdic:dic5];
                    [stepArray addObject:model];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_detailsPageTableView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showHint:@"数据异常"];
        }];
        
    }else {
        [self showHint:@"网络异常请检测网络"];
        
    }
    
}


#pragma mark- 返回按钮
- (IBAction)returnButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return stepArray.count+2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string1 = @"cell1";
    static NSString *string2 = @"cell2";
    
    if (indexPath.row == 0) {
        
        HeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string1];
        
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HeadViewCell" owner:nil options:nil]lastObject];
        }
        
        if (headViewArray.count != 0) {
            [cell setAbc:headViewArray];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }
    
    ////
    if (indexPath.row == 1) {
    
        MaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:string2];
    
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MaterialCell" owner:nil options:nil]lastObject];
        }
        
        if (materialArray.count != 0) {
                        
            for (int i = 0; i < materialArray.count; i++) {
                MaterialModel *model = materialArray[i];
                [materislName addObject:model.name];
                [materislName addObject:@" "];
                [materislName addObject:model.dosage];
                if (i+1 == materialArray.count)
                {
                    [materislName addObject:@" 。"];
                }else
                {
                    [materislName addObject:@" ,"];
                }
            }
            NSString *str = [materislName componentsJoinedByString:@""];
            [cell MaterialString:str];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
    
        StepOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"StepOneCell" owner:nil options:nil]lastObject];
        }
        
        if (stepArray.count != 0) {
            
            StepOneModel *model = [stepArray objectAtIndex:indexPath.row - 2];
            NSString *string = [NSString stringWithFormat:@"%ld",model.ordernum];
            cell.stepLabel.text = string;
            [cell.stepImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",model.imageid]] placeholderImage:[UIImage imageNamed:@"占位图"]];
            cell.explainLabel.text = model.details;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}

//第三步,执行协议方法
-(void)ChuanZhi{
    [self.delegate getArray:materialArray];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark- tool bar 三个按钮方法



#pragma mark- 收藏

- (IBAction)mark:(UIButton *)sender {
    
    
    
}



#pragma mark- 字体放大


- (IBAction)font:(UIButton *)sender {
    
    
    
    
}





#pragma mark- 分享


- (IBAction)share:(UIButton *)sender {
    
    
    
    
    
}




@end
