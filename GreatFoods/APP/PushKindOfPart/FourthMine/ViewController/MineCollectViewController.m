//
//  MineCollectViewController.m
//  美食类
//
//  Created by lynsea on 16/4/25.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "MineCollectViewController.h"
#import "DataBase.h"
#import "MineCollextCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "CollectModel.h"
#import "DaydayCookDescription.h"
@interface MineCollectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,retain)NSMutableArray *collectArr;
@end

@implementation MineCollectViewController
static NSString *cellid = @"MineCollectcell";
-(void)viewDidDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[DataBase shareData]openFmdb];
    
    self.collectArr = [[DataBase shareData]queryCollectModel];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(screen_width/2,screen_width/2 );
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView.collectionViewLayout = layout;
//    [self.collectionView registerClass:[MineCollextCollectionViewCell class] forCellWithReuseIdentifier:cellid];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MineCollextCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellid];

    self.collectionView.dataSource =self;
    self.collectionView.delegate =self;
    NSLog(@"array.count [==========%ld",self.collectArr.count);


}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    DaydayCookDescription *VC = [DaydayCookDescription new];
    
    CollectModel *model = self.collectArr[indexPath.item];
    VC.BookID = model.bookId;
    
    
    [self.navigationController pushViewController:VC animated:YES];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    

    return [self.collectArr count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    MineCollextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
//    [cell setBackgroundColor:[UIColor redColor]];
    CollectModel *model = [self.collectArr objectAtIndex:indexPath.item] ;
    
    [cell getModel:model];
    NSLog(@"~~~~~%ld",self.collectArr.count);
    return cell;
    
    
    
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
