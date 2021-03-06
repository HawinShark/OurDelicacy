//
//  MineViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "MineViewController.h"
#import "MineCollectViewController.h"
#import "MyWatchedObject.h"

#import "GuideViewController.h"
#import "ClearCacheController.h"


@interface MineViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *head;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

@implementation MineViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [head setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Goodfood%d",arc4random_uniform(29)]]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    self.navigationController.hidesBarsOnSwipe = NO;
    
    [self buildTableViewHead];
    
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"我的记录";
        case 1:
            return @"我的设置";
        case 2:
            return @"我的引导";
        default:
            break;
    }
    return @"";
}


-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return @"这里有可以清除系统缓存,以及查看本app的相关信息";
    }
    
    if (section == 2) {
        return @"The Shows of Guides";
    }
    
    return nil;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"mine";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.textLabel.textColor = RGB(92, 58, 64);
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"我的收藏";
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"我的足迹";
    }
    
    
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"设置";
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"引导页面";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}



#pragma mark- 点击跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MineCollectViewController *mineCollectVc = [[MineCollectViewController alloc]init];
            [self.navigationController pushViewController:mineCollectVc animated:YES];
        }
        if (indexPath.row == 1) {
            MyWatchedObject *watch = [[MyWatchedObject alloc]init];
            [self.navigationController pushViewController:watch animated:YES];
        }
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        ClearCacheController *clear = [ClearCacheController new];
        
        [self.navigationController pushViewController:clear animated:YES];
    }
    
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        GuideViewController *guide = [GuideViewController new];
        guide.isMajor = YES;
        [self.navigationController pushViewController:guide animated:YES];
    }
    
}

//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1 | section == 2) {
        return 1;
    }

    return 2;
}



















#pragma mark- 添加透视图 图片

- (void)buildTableViewHead
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Goodfood%d",arc4random_uniform(29)]];
    
    head = [UIImageView new];
    
    head.image = image;
    
    head.frame = CGRectMake(0, 0, screen_width, 250);
    
    head.contentMode = UIViewContentModeScaleAspectFill;
    
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 250)];
    
    [mask addSubview:head];
    
    self.tableview.tableHeaderView = mask;
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y < 0) {
        
        
        CGFloat offset = scrollView.contentOffset.y * -1;
        
        head.frame =CGRectMake(-offset/2, -offset, screen_width + offset,250  + offset);
        
    }
}



-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate)
    if (scrollView.contentOffset.y < 0) {
        
        [UIView animateWithDuration:0.5 animations:^{
            [head setFrame:CGRectMake(0, 0, screen_width, 250)];
            [scrollView setContentOffset:CGPointZero animated:YES];
        }];
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
