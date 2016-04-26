//
//  SearchViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/20.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomSearchBar.h"
#import "SearchNextViewController.h"
#import "WHC_NavigationController.h"
#import "ICarouselImages.h"

#import "DaydayCookData.h"//model
#import "SearchListViewCell.h"
@interface SearchViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    WHC_NavigationController *SearchNav;
    ICarouselImages *image;//轮播图控制
    CustomSearchBar *search;//自定义搜索
}
@property(nonatomic,retain) SearchNextViewController *controller;
@property (weak, nonatomic) IBOutlet UICollectionView *searchCollectionView;

@end

@implementation SearchViewController


-(void)viewWillAppear:(BOOL)animated{
    self.title = @"搜索菜谱";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.hidesBarsOnSwipe = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    [self LunBo];
    

    [self buildCollect];
}




#pragma mark- 自定义collection

-(void)buildCollect{
    
    self.searchCollectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self.searchCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"listcell"];//cell1
    
    [self.searchCollectionView registerNib:[UINib nibWithNibName:@"SearchListViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"listcell2"];
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(screen_width, screen_width * (3.0/5.0));
    }
    
    return CGSizeMake(screen_width * 0.42, 275);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsMake(0, 20, 10, 20);
}


#pragma mark- collection delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return self.dataModels.count;
}




-(void)LunBo
{
    image = [[ICarouselImages alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_width * (3.0/5.4))];
    
    //search
    search = [[CustomSearchBar alloc]initWithFrame:CGRectMake(40, H(image) - 45, screen_width - 80, 40)];
    [search getBlockFromOutSpace:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    
    //当按下return
    [search getClickFromReturn:^(NSString *str) {
        //
        
        [self modal];
        
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        self.controller.name = str;
        
        //跳转
        [self ModelToNext];
        
        
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listcell" forIndexPath:indexPath];
        
        //image
        
        
        [cell.contentView addSubview:image];
        
        [cell.contentView addSubview:search];
        
        cell.contentView.backgroundColor = BabyPinkColor;
        
        return cell;
    }//cell1
    
    
    SearchListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listcell2" forIndexPath:indexPath];
    
    DaydayCookData *model = _dataModels[indexPath.row];
    [cell GetModel:model];
    
    return cell;
}




#pragma mark- 滑动停止轮播图

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [image.ica stopAutoScrollPage];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [image.ica startAutoScrollPage];
}




#pragma mark- 创建自定义search











- (void)modal{
    _controller = [[SearchNextViewController alloc] init];
    _controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    SearchNav = [[WHC_NavigationController alloc]initWithRootViewController:_controller];
}






- (void)ModelToNext{
    if (IOS_VERSION >= 8.0) {
        
        
        _controller.providesPresentationContextTransitionStyle = YES;
        _controller.definesPresentationContext = YES;
        _controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:SearchNav animated:YES completion:nil];
        
    } else {
        
        
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:SearchNav animated:NO completion:nil];
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
}



- (void)GetData{
    
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
