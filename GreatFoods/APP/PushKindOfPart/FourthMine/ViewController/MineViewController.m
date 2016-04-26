//
//  MineViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "MineViewController.h"
#import "MineCollectViewController.h"

@interface MineViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

@implementation MineViewController
-(void)viewWillAppear:(BOOL)animated{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    
    
    [self buildTableViewHead];
    
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
//    if (section == 0) {
//        return @"Good";
//    }
//    else{
//        return @"Bad";
//    }
    return @" ";
}
//
//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return @"good";
//    }
//    return @"bad";
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"mine";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"我的收藏";
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"我的足迹";
    }
    
    
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"设置";
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MineCollectViewController *mineCollectVc = [[MineCollectViewController alloc]init];
            [self.navigationController pushViewController:mineCollectVc animated:YES];
        }
    }
    
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}



















#pragma mark- 添加透视图 图片

- (void)buildTableViewHead
{
    UIImage *image = [UIImage imageNamed:@"background-1"];
    
    UIImageView *head = [UIImageView new];
    
    head.image = image;
    
    head.frame = CGRectMake(0, 0, screen_width, 250);
    
    head.contentMode = UIViewContentModeScaleAspectFill;
    
    
    self.tableview.tableHeaderView = head;
    
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
