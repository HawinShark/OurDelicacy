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

#import "DataBase.h"
#import "CollectModel.h"
#import "UMSocialDataService.h"
#import "UMSocial.h"

@interface DetailsPageController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
{
    NSMutableArray *array;
    NSMutableArray *array1;
    NSMutableArray *headViewArray;
    NSMutableArray *materialArray;
    NSMutableArray *materislName;
    NSMutableArray *materislNum;
    NSMutableArray *stepArray;
    NSMutableDictionary *dic;
    
    
  //收藏数据
    NSString *_imgUrl;
    NSString *_bookId;
    NSString *_title;
    UIImage *_image;
    
    BOOL isCollect;
    
}
@property (weak, nonatomic) IBOutlet UITableView *detailsPageTableView;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
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
    
    
    if (headViewArray.count > 0) {
        
        HeadViewCell *cell = [self.detailsPageTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0 ]];
        cell.imageBlock = ^(UIImage *image){
            
            _image = image;
        };
        

    }
    
    
    //让底下的tabbar不会挡住tableView的内容
    [self.detailsPageTableView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
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
            
            //获取收藏的数据
            
            NSDictionary *collectDic = [[responseObject objectForKey:@"list"]objectAtIndex:0];
            _title = [collectDic objectForKey:@"name"];
            NSLog(@"%@",_title);
            _imgUrl = [NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",[collectDic objectForKey:@"imageid"]];
            
            NSLog(@"imgUrl = %@",_imgUrl);
            _bookId = _DetailsId;
            
            
            [[DataBase shareData]openFmdb];
            NSMutableArray *infoArr  = [[DataBase shareData]queryMakeTitle];
            for (NSString *title in infoArr) {
                if ([_title isEqualToString:title]) {
                    isCollect= YES;
                    self.collectBtn.selected = YES;
                }
            }
            
            
            
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
            
        
            
#pragma mark- 足迹浏览过
            [[DataBase shareData]creatAndOpenTable];//open
            CollectModel *WatchModel = [CollectModel new];
            WatchModel.makeTitle = _title;
            WatchModel.bookId = [_DetailsId integerValue];
            WatchModel.imgUrl = _imgUrl;
            WatchModel.VcName = @"BreakFast";            //先删除后存储
            [[DataBase shareData]deletePeopleWithMakeTitle:_title];
            [[DataBase shareData]insertPeople:WatchModel];//存入数据库
            
            
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

//隐藏电池栏
-(BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark- tool bar 三个按钮方法



#pragma mark- 收藏

- (IBAction)mark:(UIButton *)sender {
    
    if (sender.selected == NO) {
        CollectModel *model = [CollectModel new];
       model.makeTitle = _title;
        model.bookId = [_DetailsId integerValue];
        model.imgUrl = _imgUrl;
        model.VcName = @"BreakFast";
//
        [[DataBase shareData]insertInfo:model];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏成功" message:@"已加入收藏\n快进入我的收藏里查看吧~" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [self presentViewController:alert animated:YES completion:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }else{
//        [[DataBase shareData]deleteInfo:self.makeTitle];
        
        //取消收藏
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"取消成功" message:@"已取消收藏" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [self presentViewController:alert animated:YES completion:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }
    sender.selected = !sender.selected;
    
}



#pragma mark- 字体放大


- (IBAction)font:(UIButton *)sender {
    
    
    
    
}





#pragma mark- 分享


- (IBAction)share:(UIButton *)sender {
//    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5720b91867e58efd09002f70"                                    shareText:self.title
                                     shareImage:_image
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
                                       delegate:self];
    
    
//    NSLog(@"self.title == %@",self.makeTitle);
    
    NSString *url = [NSString stringWithFormat:@"http://m.ecook.cn/recipeDetail/%@?from=timeline&isappinstalled=1",self.DetailsId];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = self.title;
    
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = _title;
    [UMSocialData defaultData].extConfig.wxMessageType =  UMSocialWXMessageTypeWeb;
    //
//
//    
    
}




@end
