//
//  BreakFastViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "BreakFastViewController.h"
#import "IndexFirstCell.h"
#import "IndexSecondCell.h"
#import "IndexThirdCell.h"

#import "List.h"

#import <AFNetworking.h>

NSMutableArray *first;
NSMutableArray *second;
NSMutableArray *third;//分别装三种数据

NSUInteger cellcount = 0;//cell的个数

@interface BreakFastViewController () <UITableViewDataSource,UITableViewDelegate>


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
    
}








#pragma mark- 创建UI

- (void) buildUI
{
    // your code
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 200;    //估高
    
    
    
}











#pragma mark- tableviewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (cellcount != 0) {
        
        return cellcount / 2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"breakFirst";
    static NSString *cellidTwo = @"breakSecond";
    static NSString *cellidThree = @"breakThird";
    
    
    //第一种cell (三个)
    if (indexPath.row % 6 == 0 ) {
        
        IndexFirstCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"IndexFirstCell" owner:self options:nil] lastObject];
        if (!cell) {
            cell = [[IndexFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        
         NSInteger sum = indexPath.row / 6 * 3;
        
        if (first.count != 0) {
            
            [cell getModel:first[sum]
                  ModelTwo:first[sum + 1]
                ModelThree:first[sum + 2]];
        }
        
        return cell;
    }
    
    
    //第二种cell (一个大)
    if (indexPath.row % 6 == 1 | indexPath.row % 6 == 2 | indexPath.row % 6 == 3 | indexPath.row % 6 == 5
        ) {
        IndexSecondCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"IndexSecondCell" owner:nil options:nil]lastObject];
        if (!cell) {
            cell = [[IndexSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidTwo];
        }
        
        if (second.count != 0) {
            
            if (indexPath.row % 6 == 5) {
                
                NSInteger sum = indexPath.row % 6 + (indexPath.row / 6 * 3) - 2;
                
                [cell Get:second[sum]];
                
            } else {
            
            NSInteger sum = indexPath.row % 6 + (indexPath.row / 6 * 3) - 1;

            [cell Get:second[sum]];
            
            }
        }
        
        return cell;
    }else
    {
        //第三种cell (五个)
        IndexThirdCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"IndexThirdCell" owner:nil options:nil]lastObject];
        if (!cell) {
            cell = [[IndexThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidThree];
        }
        
        NSInteger sum = indexPath.row / 5 * 5;
        
        NSLog(@"%ld",third.count);
        
        [cell Get:third[sum] two:third[sum + 1] three:third[sum + 2] four:third[sum + 3] five:third[sum + 4]];
        
        return cell;
    }
}




#pragma mark- tableviewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}



#pragma mark- 异步获取数据
- (void)GetData{
    //三种数据
    first  = [NSMutableArray new];
    second = [NSMutableArray new];
    third  = [NSMutableArray new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:@"http://42.121.253.143/public/getContentsBySubClassid.shtml?id=7136465&page=0&type=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //解析数据
//        NSLog(@"responseObject = %@",responseObject);
        
        NSArray *array = [responseObject objectForKey:@"list"];
        
        cellcount = [array count];//获取cell的个数
        
        for (int i = 0; i < array.count; i++) {
            
            NSDictionary *data = array[i];
            
            List *model = [List modelObjectWithDictionary:data];
            
            if (i % 12 == 0 |  i % 12 == 1 | i % 12 == 2) {
                
                [first addObject:model];
                
            }
            
            //第二种cell (一个大)
            else if (i % 12 == 3 | i % 12 == 4 | i % 12 == 5 | i % 12 == 11
                ) {
                
                [second addObject:model];
            }
            
            //第三种cell (五个)
            else{
                [third addObject:model];
            }
            
            //
        }
        
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
