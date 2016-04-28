//
//  MyWatchedObject.m
//  美食类
//
//  Created by 夏浩文 on 16/4/27.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "MyWatchedObject.h"
#import "DataBase.h"//数据
#import "CollectModel.h"
#import "DaydayCookDescription.h"

#import "MineCollextCollectionViewCell.h"
@interface MyWatchedObject () <UICollectionViewDataSource,UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *MyCollectView;

//数量
@property (nonatomic, retain) NSMutableArray *WatchArray;
@property (weak, nonatomic) IBOutlet UILabel *Foots;

@end

@implementation MyWatchedObject


-(NSMutableArray *)WatchArray{
    if (!_WatchArray) {
        _WatchArray = [[NSMutableArray alloc]init];
    }
    return _WatchArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的足迹";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"清除全部" style:UIBarButtonItemStylePlain target:self action:@selector(Clear:)];
    [self.navigationItem.rightBarButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(2, -1) forBarMetrics:UIBarMetricsDefault];
    
    //打开数据库
    [[DataBase shareData]creatAndOpenTable];
    //读取
    self.WatchArray = [[DataBase shareData]selectMovie];
    //
    NSLog(@"%ld",self.WatchArray.count);
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    layout.itemSize = CGSizeMake(screen_width / 2 , screen_width / 2);
    
    layout.minimumLineSpacing      = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.MyCollectView.collectionViewLayout = layout;
    
    [self.MyCollectView registerNib:[UINib nibWithNibName:@"MineCollextCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MineCollectcell"];
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_WatchArray count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MineCollextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineCollectcell" forIndexPath:indexPath];
    
    CollectModel *model = _WatchArray[indexPath.item];
    
    [cell getModel:model];
    
    return cell;
}



- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectModel *model = _WatchArray[indexPath.item];
    
    DaydayCookDescription *vc = [DaydayCookDescription new];
    
    vc.BookID = model.bookId;
    
    vc.isNavigation = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    return NO;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_WatchArray.count > 0) {
        _Foots.hidden = YES;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)Clear:(UIButton *)sender
{
    //1
    [[DataBase shareData]delectALL];
    //2
    [_WatchArray removeAllObjects];
    //3
    [self.MyCollectView reloadData];
    //4
    _Foots.hidden = NO;
    //5
    UIAlertController *great = [UIAlertController alertControllerWithTitle:@"删除成功" message:@"已删除所有浏览记录" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:great animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [great dismissViewControllerAnimated:YES completion:nil];
        });
    }];
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
