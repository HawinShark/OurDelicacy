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
@property (weak, nonatomic) IBOutlet UIButton *allSelectBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *selectView;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property(nonatomic,retain)NSMutableArray *collectArr;
@property(nonatomic,assign)BOOL isSelect;
@property (nonatomic,retain) NSMutableArray *deleteArr;
@end

@implementation MineCollectViewController
static NSString *cellid = @"MineCollectcell";


-(NSMutableArray *)deleteArr{
    if (!_deleteArr)
    {
        _deleteArr = [NSMutableArray array];
    }
    
    return _deleteArr;
    
}
- (IBAction)allSelectAction:(UIButton *)sender {
    
    
    for (int i = 0; i < _collectArr.count; i++){
        
        MineCollextCollectionViewCell *cell = (MineCollextCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        cell.selected =! cell.selected;
    }
    
    sender.selected = !sender.selected;
}

- (IBAction)deleteAction:(UIButton *)sender {
    [[DataBase shareData]openFmdb];
    
    for (NSString *str in self.deleteArr) {
        [[DataBase shareData]deleteInfo:str];
        [self.deleteArr removeObject:str];
    }
    if (self.deleteArr.count == 0) {
        self.deleteBtn.enabled = NO;
    }
    
    self.collectArr = [[DataBase shareData]queryCollectModel];
    [self.collectionView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    self.automaticallyAdjustsScrollViewInsets = NO;

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
    [self.collectionView registerNib:[UINib nibWithNibName:@"MineCollextCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellid];

    self.collectionView.dataSource =self;
    self.collectionView.delegate =self;
    [self setSelectBtn];

}
-(void) setSelectBtn{
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [selectBtn setTitle:@"选择" forState:UIControlStateNormal];
    [selectBtn setTitle:@"取消" forState:UIControlStateSelected];
    selectBtn.frame = CGRectMake(0, 0, 50, 30);
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *seleteItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
    
    self.navigationItem.rightBarButtonItem = seleteItem;
    
}
-(void) selectAction:(UIButton *)btn{
    if (btn.selected == NO) {
        self.collectionView.allowsMultipleSelection = YES;
        self.isSelect = YES;
        [UIView animateWithDuration:0.1 animations:^{
            self.selectView.transform = CGAffineTransformTranslate(self.selectView.transform, 0, -40);
        } completion:^(BOOL finished) {
            
        }];
        
        
        
    }
    else{
        [UIView animateWithDuration:0.1 animations:^{
            self.selectView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        
        
        self.collectionView.allowsMultipleSelection = NO;
        self.collectionView.allowsSelection = NO;
        self.collectionView.allowsSelection = YES;
        self.isSelect = NO;
        [self.deleteArr removeAllObjects];
        
    }
    
    btn.selected = !btn.selected;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectModel *model = self.collectArr[indexPath.item];


    if (self.isSelect == NO) {
       
        DaydayCookDescription *VC = [DaydayCookDescription new];
        
        VC.BookID = model.bookId;
        VC.isNavigation = YES;
        
        [self.navigationController pushViewController:VC animated:YES];
        return NO;
    }
    else
        
    {
        
        [self.deleteArr addObject:model.makeTitle];
        
        if (self.deleteArr.count > 0) {
        
            self.deleteBtn.enabled = YES;
        }
        
        return YES;
    }
    
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectModel *model = self.collectArr[indexPath.item];

    [self.deleteArr removeObject:model.makeTitle];
    if (self.deleteArr.count == 0) {
        self.deleteBtn.enabled = NO;
    }
    
    return YES;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    

    return [self.collectArr count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    MineCollextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    CollectModel *model = [self.collectArr objectAtIndex:indexPath.item] ;
    
    [cell getModel:model];
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
