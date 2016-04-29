//
//  DaydayHome.m
//  美食类
//
//  Created by 夏浩文 on 16/4/18.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "DaydayHome.h"
#import "DDCollectCell.h"
#import "DDCLoopLayout.h"
#import "DDPushList.h"
#import "DaydayCookDescription.h"

#import "TimerViewController.h"

#import <AFNetworking.h>
#import <UIView+SDAutoLayout.h>
#import <UIScrollView+JElasticPullToRefresh.h>
#import <MJRefreshNormalHeader.h>
//#import <MJRefreshGifHeader.h>
#import "FilmManager.h"

@interface DaydayHome () <UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
{
    DDPushList *PushListView;//导航菜单
    
    UIButton *backtoTop;
    
    DDCLoopLayout *layout;
    DDCollectCell *currentTopCell;
    
    FilmManager *filmmanager;
    NSInteger currentIndex;
    
    NSInteger firstTime;
    
    BOOL isWIFI;
}
@property (retain, nonatomic) UICollectionView *DaydayCollecionView;
@property (weak, nonatomic) IBOutlet UIButton *ListButton;//推出按钮

@end

@implementation DaydayHome


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (firstTime == 0) {
        [self uptodownRefresh];
//        [UIView setAnimationsEnabled:NO];
        firstTime = 1;
    }

    
    /* 去除该死的bar发际线 (背景navbar合一)perfect */
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = RGB(56, 13, 49);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(89, 61, 67),NSFontAttributeName : [UIFont fontWithName:@"Zapfino" size:15]}];

    self.DaydayCollecionView.backgroundColor = RGB(251, 246, 243);
    
    if (self.navigationController.navigationBarHidden == YES) {
        self.navigationController.navigationBarHidden = NO;
    }
    
    /**
     *  @author 夏浩文
     *
     *  菜单列表按钮
     *
     */
    
    self.title = @"DayDayCook";
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    /**
     *  @author 夏浩文
     *
     *  collectionview
     */
    layout = [[DDCLoopLayout alloc]init];
    
    [layout setCurrentIndex:^(NSInteger index) {
        currentIndex = index;
    }];//回调第一个
    
    self.DaydayCollecionView = [[UICollectionView alloc]
                                initWithFrame:self.view.frame collectionViewLayout:layout];
    self.DaydayCollecionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_DaydayCollecionView];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
#pragma mark- 获取数据源
    
    self.DaydayCollecionView.delegate = self;
    self.DaydayCollecionView.dataSource = self;
    
    //注册cell
    [self.DaydayCollecionView registerNib:[UINib nibWithNibName:@"DDCollectCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"daydayhome"];
    //平滑速度
    [self.DaydayCollecionView setDecelerationRate:UIScrollViewDecelerationRateFast];

    #pragma mark- 调用创建退出窗口方法
    [self buildPushListView];
    
    #pragma mark- 回顶部按钮创建
    [self backToTop];
    
    #pragma mark- 添加下拉刷新
    
    
    MJRefreshNormalHeader *head = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self uptodownRefresh];
    }];
    self.DaydayCollecionView.mj_header = head;
    
    //color
    head.stateLabel.textColor = [UIColor whiteColor];
    
    head.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    
    if ([self isWIFI] == YES) {
        isWIFI = YES;
    }
}

  









#pragma mark- UICollectionViewDataSource
//
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.DDdataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    #pragma mark- cell代理方法
    
    static NSString *cellid = @"daydayhome";
    DDCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    
    DaydayCookData *model = self.DDdataArray[indexPath.item];
    [cell getModel:model];
    return cell;
}







#pragma mark- UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DaydayCookDescription *VC = [DaydayCookDescription new];
    
    DaydayCookData *model = self.DDdataArray[indexPath.item];
    VC.BookID = model.dataIdentifier;
    
    [self.navigationController pushViewController:VC animated:YES];
}









#pragma mark- scrolldelegate


//按钮出现

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
        if (decelerate) {
        
        if (scrollView.contentOffset.y > screen_height / 2 && scrollView.contentOffset.y < screen_height * 1.8) {
            [UIView animateWithDuration:.5 animations:^{
                backtoTop.alpha = 1;
            }];
        }
        if (scrollView.contentOffset.y > screen_height * 1.8) {
            backtoTop.alpha = 1;
        }
        
        //按钮消失
        if (scrollView.contentOffset.y < screen_height/2) {
            [UIView animateWithDuration:.5 animations:^{
                backtoTop.alpha = 0;
            }];
        }
        
    }
    
    //刷新时隐藏导航栏(如果刷新状态了)
    if (self.DaydayCollecionView.mj_header.state == MJRefreshStatePulling) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
    //刷新数据
    if (scrollView.contentOffset.y / 180  > self.DDdataArray.count - 20 ) {
        
    #pragma mark- 上拉加载请求数据
        dispatch_async(dispatch_queue_create("new", DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
            
            [self DayDayCookHomeDataIFRefresh:YES];
        });
    }//减速判定是否刷新页面
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (isWIFI == YES) {
                //中断视频播放
                if (currentTopCell.isPlay == YES) {
                    
                    [filmmanager suspend];
                    filmmanager.hidden = YES;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [filmmanager removeFromSuperview];
                        filmmanager = nil;//执行dealloc
                    });
                }
            }
        });
        
    });
    
    
    
}




#pragma mark- 控制视频播放
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    static NSInteger topCell ;
    topCell = scrollView.contentOffset.y / 180;
    
//    NSLog(@"num = %ld", (long)topCell);
    
    
    if (self.DaydayCollecionView.mj_header.state == MJRefreshStateIdle) {
    
    if (self.DDdataArray.count > 0)
    if (currentIndex == topCell) {
        
        currentTopCell = (DDCollectCell *)[self.DaydayCollecionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:topCell inSection:0]];
        DaydayCookData *model = self.DDdataArray[currentIndex];
        if (model.indexUrl.length > 0) {
            
            NSLog(@"有种子");
            
            if (isWIFI == YES) {
                
                //延迟执行
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    filmmanager = [[FilmManager alloc]initWithFrame:currentTopCell.contentView.bounds WithUrl:model.indexUrl];
                    //  执行的代码
                    
                    [currentTopCell.contentView addSubview:filmmanager];
                    [currentTopCell.contentView insertSubview:filmmanager aboveSubview:currentTopCell.BackGroundImage];
                    //
                    
                    currentTopCell.isPlay = YES;
                    
                    
                    //----->>>>>>>
                });
            }//如果是wifi状态
            
            
        }
        
    }
  }
}












#pragma mark- 菜单推出导航页面
- (void)buildPushListView{
    PushListView = [[[NSBundle mainBundle]loadNibNamed:@"DDPushList" owner:self options:nil] lastObject];
    PushListView.timerVc = [TimerViewController new];
    [PushListView setFrame:CGRectMake(0, screen_height, screen_width, 170)];
    
    [self.view addSubview:PushListView];
    [self.view bringSubviewToFront:PushListView];
}











#pragma mark- 菜单列表按钮
- (IBAction)PushList:(UIButton *)sender
{
    //不允许点击
    self.DaydayCollecionView.userInteractionEnabled = NO;
    //navBar上移
    [UIView animateWithDuration:1 animations:^{
        
        sender.alpha = 0;
        if (backtoTop.alpha == 1) {
            backtoTop.alpha = 0;
        }
        
        [self.navigationController.navigationBar setAlpha:0];
        self.navigationController.navigationBar.transform = CGAffineTransformTranslate(self.navigationController.navigationBar.transform, 0, -64);//向上移动
    }];
    //pushView上移
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        PushListView.transform = CGAffineTransformTranslate(PushListView.transform, 0, -170);
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//状态栏白色
        self.DaydayCollecionView.transform = CGAffineTransformTranslate(PushListView.transform, 0, 0);
    } completion:^(BOOL finished) {
        NSLog(@"animate completly");
    }];
}
//导航回滚
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //pushView下移
    [UIView animateWithDuration:.5 animations:^{
        PushListView.transform = CGAffineTransformIdentity;
        self.DaydayCollecionView.transform = CGAffineTransformTranslate(PushListView.transform, 0, 0);
    } completion:^(BOOL finished) {
        //navBar下移
        [UIView animateWithDuration:.3 animations:^{
            self.ListButton.alpha = 1;
            if (backtoTop.tag != 0 && backtoTop.tag != 1) {
                backtoTop.alpha = 1;
            }
            
            [self.navigationController.navigationBar setAlpha:1];
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//状态栏
            //允许点击
            self.DaydayCollecionView.userInteractionEnabled = YES;
        }];
        self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
    }];
    

    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}




#pragma mark- 刷新页面

-(void)DayDayCookHomeDataIFRefresh:(BOOL)isrefresh;
{
    if ([self isNetWork]) {
        
    
    if (isrefresh == YES) {
        RefreshCurrentPage++;//下拉刷新
    }
    NSString *url = [NSString stringWithFormat:@"http://218.244.151.213/daydaycook/server/recipe/index.do?currentPage=%ld&pageSize=30",(long)RefreshCurrentPage];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            
            NSArray *dataArray = responseObject[@"data"];
            for (NSDictionary *dic in dataArray) {
                DaydayCookData *model = [DaydayCookData modelObjectWithDictionary:dic];
                [self.DDdataArray addObject:model];
            }
            /* 刷新*/
            
                
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //  执行的代码
                if (RefreshCurrentPage > 0) {
                    
                        NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
                            [self.DaydayCollecionView reloadSections:set];

                }
            });
            
            
        }
    } failure:nil];
        
    
        //加载内..
    }
}


- (void)uptodownRefresh
{
    if ([self isNetWork]) {
        
        self.DDdataArray = [NSMutableArray array];//初始化
        
        NSString *url;
        
        if (RefreshCurrentPage > 0) {
            url = [NSString stringWithFormat:@"http://218.244.151.213/daydaycook/server/recipe/index.do?currentPage=0&pageSize=%ld",RefreshCurrentPage * 30];
        }else{
            url = [NSString stringWithFormat:@"http://218.244.151.213/daydaycook/server/recipe/index.do?currentPage=0&pageSize=%ld",(RefreshCurrentPage + 1) * 30];
        }//第一进页面刷新数据
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
                
                
                NSArray *dataArray = responseObject[@"data"];
                for (NSDictionary *dic in dataArray) {
                    DaydayCookData *model = [DaydayCookData modelObjectWithDictionary:dic];
                    [self.DDdataArray addObject:model];
                }
                /* 刷新*/
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.DaydayCollecionView.mj_header endRefreshing];
                    //  执行的代码
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                        [UIView setAnimationsEnabled:YES];
                        
                        [self.DaydayCollecionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
                        [self.navigationController setNavigationBarHidden:NO animated:YES];
                    });
                    
                    
                        //----->>>>>>>
                });
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showHint:@"加载失败"];
        }];
        //加载内..
    }
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








#pragma mark- 添加渐变色











#pragma mark- 释放动画
-(void)dealloc
{
    NSLog(@"释放~");
}











#pragma mark- 按钮回到顶部

-(void) backToTop
{
    backtoTop = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backtoTop];
    [self.view bringSubviewToFront:backtoTop];
    
    backtoTop.sd_layout.bottomSpaceToView(self.view,35).rightSpaceToView(self.view,25).widthIs(50).heightEqualToWidth();
    [backtoTop setTitle:@"Back" forState:UIControlStateNormal];
    backtoTop.titleLabel.font = [UIFont fontWithName:@"Zapfino" size:15];
    
//    [backtoTop setImage:[UIImage imageNamed:@"top"] forState:UIControlStateNormal];
    backtoTop.titleLabel.textColor = [UIColor whiteColor];
    
    backtoTop.alpha = 0;
    [backtoTop addTarget:self action:@selector(totop:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void) totop:(UIButton *)sender
{
    [self.DaydayCollecionView setContentOffset:CGPointZero animated:YES]; //1有动画

            //销毁播放器
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (isWIFI == YES) {
                //中断视频播放
                if (currentTopCell.isPlay == YES) {
                    
                    [filmmanager suspend];
                    filmmanager.hidden = YES;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [filmmanager removeFromSuperview];
                        filmmanager = nil;//执行dealloc
                    });
                }
            }
        });
        
    });



    
    //置顶后按钮消失
    [UIView animateWithDuration:.5 animations:^{
        backtoTop.alpha = 0;
    }];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (isWIFI == YES) {
                //中断视频播放
                if (currentTopCell.isPlay == YES) {
                    
                    [filmmanager suspend];
                    filmmanager.hidden = YES;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [filmmanager removeFromSuperview];
                        filmmanager = nil;//执行dealloc
                    });
                }
            }
        });
        
    });
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
