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
@interface DetailsPageController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *array;
    NSMutableArray *array1;
    NSMutableArray *headViewArray;
    NSMutableArray *materialArray;
    NSMutableArray *stepArray;
    NSMutableDictionary *dic;
}
@property (weak, nonatomic) IBOutlet UITableView *detailsPageTableView;
@end

@implementation DetailsPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    array = [NSMutableArray new];
    array1 = [NSMutableArray new];
    headViewArray = [NSMutableArray new];
    materialArray = [NSMutableArray new];
    stepArray = [NSMutableArray new];
    dic = [NSMutableDictionary new];

    _returnButton.alpha = 0.2;
    
    self.detailsPageTableView.rowHeight = UITableViewAutomaticDimension;
    self.detailsPageTableView.estimatedRowHeight = 200;
    
    [self RequestsData];
    
}

//网络请求
-(void)RequestsData
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"http://42.121.253.143/public/getRecipeListByIds.shtml?ids=%@",_DetailsId] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dic = [dic1 objectForKey:@"list"];
        
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
        
    }];
    
//    [NetworkRequestManager requestWithType:POST urlString:[NSString stringWithFormat:@"http://42.121.253.143/public/getRecipeListByIds.shtml?ids=%@",_DetailsId] parDic:nil finish:^(NSData *data) {
//        
//    } error:^(NSError *error) {
//        NSLog(@"错误");
//    }];
}

//返回按钮点击方法
- (IBAction)returnButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return stepArray.count+2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string = @"cell";
    
    if (indexPath.row == 0) {
        
        HeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
        
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
    
        MaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    
        if (cell == nil)
        {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MaterialCell" owner:nil options:nil]lastObject];
        }
        
        if (materialArray.count != 0) {
            
            [cell setAbc:materialArray];
//            cell.reload();
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
            [cell.stepImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",model.imageid]]];
            cell.explainLabel.text = model.details;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
