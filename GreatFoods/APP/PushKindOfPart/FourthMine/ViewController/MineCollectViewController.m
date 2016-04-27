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
#import <OpinionzAlertView.h>
#import "CollectModel.h"
#import "DaydayCookDescription.h"
@interface MineCollectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *allSelectBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *selectView;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property(nonatomic,retain)NSMutableArray *collectArr;

//是否在选择状态
@property(nonatomic,assign)BOOL isSelect;

//是否在全选状态
@property (nonatomic,assign) BOOL isAllselect;

//要删除的数组
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

#pragma mark - 全选按钮方法
- (IBAction)allSelectAction:(UIButton *)sender {
    
    if (sender.selected == NO) {
        self.deleteBtn.enabled =YES;
        self.deleteArr = [[DataBase shareData]queryMakeTitle];
        self.title =[NSString stringWithFormat:@"已选%ld个菜谱",[self.deleteArr count] ];

        
    }
    else{
        [self.deleteArr removeAllObjects];
        self.title =[NSString stringWithFormat:@"已选%ld个菜谱",[self.deleteArr count] ];

        self.deleteBtn.enabled = NO;
    }

    NSArray *cellArr = [self.collectionView visibleCells];
    for (MineCollextCollectionViewCell *cell in cellArr) {
                cell.selected =! cell.selected;

    }
    
    self.isAllselect = !self.isAllselect;
    sender.selected = !sender.selected;
}

#pragma mark - 删除按钮方法
- (IBAction)deleteAction:(UIButton *)sender {
    [[DataBase shareData]openFmdb];
    
    for (NSString *str in self.deleteArr) {
        [[DataBase shareData]deleteInfo:str];
    }
    [self.deleteArr removeAllObjects];
        self.deleteBtn.enabled = NO;

    
    self.collectArr = [[DataBase shareData]queryCollectModel];
    
    //删除成功alert
    
    OpinionzAlertView *alert = [[OpinionzAlertView alloc]initWithTitle:@"删除成功" message:@"要添加更多菜谱哦~" cancelButtonTitle:@"okay" otherButtonTitles:nil];
    alert.iconType = OpinionzAlertIconSuccess;
    [alert show];
    
    self.title =[NSString stringWithFormat:@"已选%ld个菜谱",[self.deleteArr count] ];

    [self.collectionView reloadData];
    
    //且返回上级页面
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    
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
//    self.navigationController.navigationBar.
    self.title =[NSString stringWithFormat:@"我的收藏(%ld)",[self.collectArr count] ];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :  [UIColor orangeColor]}];
//    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
   
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
#pragma mark - 选择按钮方法
-(void) selectAction:(UIButton *)btn{
    if (btn.selected == NO) {
        self.title =[NSString stringWithFormat:@"已选0个菜谱" ];

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
        
        self.allSelectBtn.selected = NO;
        NSArray *cellArr = [self.collectionView visibleCells];
        for (MineCollextCollectionViewCell *cell in cellArr) {
            cell.selected =NO;
            
        }
        self.isAllselect = NO;
        
        
        self.collectionView.allowsMultipleSelection = NO;
        self.collectionView.allowsSelection = YES;
        self.isSelect = NO;
        [self.deleteArr removeAllObjects];
        self.deleteBtn.enabled = NO;
        
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
        self.title =[NSString stringWithFormat:@"已选%ld个菜谱",[self.deleteArr count] ];

        
        if (self.deleteArr.count > 0) {
        
            self.deleteBtn.enabled = YES;
        }
        
        return YES;
    }
    
}


-(BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectModel *model = self.collectArr[indexPath.item];

    [self.deleteArr removeObject:model.makeTitle];
    self.title =[NSString stringWithFormat:@"已选%ld个菜谱",[self.deleteArr count] ];

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
    
    if (self.isAllselect == YES) {
        cell.selected = YES;
    }

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


-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(89, 61, 67),NSFontAttributeName : [UIFont fontWithName:@"Zapfino" size:15]}];
}

@end
