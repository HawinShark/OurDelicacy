//
//  TimerViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "TimerViewController.h"
#import "BigRoundView.h"
#import "SmRoundView.h"
#import "PointView.h"
#import "Timer.h"
#import <UIImageView+WebCache.h>
#import <UIImage+AFNetworking.h>
#import "TimerModel.h"
@interface TimerViewController () <TimerDelegate>
@property (weak, nonatomic) IBOutlet SmRoundView *smRoundView;
@property (weak, nonatomic) IBOutlet BigRoundView *bigRoundView;
@property (weak, nonatomic) IBOutlet PointView *pointView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIView *timeoutView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;

@property (weak, nonatomic) IBOutlet UIImageView *foodImgView;
@property(nonatomic,strong)dispatch_source_t time;
@property(nonatomic,strong)dispatch_source_t time1;
@property(nonatomic,assign)NSInteger timeout;
@property(nonatomic,assign)CGFloat progressCount;
@property(nonatomic,retain) UIColor *color;
@property(nonatomic,retain) UIButton *addMinBtn;
@property(nonatomic,retain)NSMutableArray *imageArr;


@end

@implementation TimerViewController



//开始计时
- (IBAction)startAction:(id)sender {
    if ([self.countLabel.text integerValue] ==0) {
        
    }else{
        
        [Timer shareTimer].timeCount = [self.countLabel.text integerValue] * 60;
        [[Timer shareTimer]startTimer];
        [self action];
    }
}
//暂停按钮
- (IBAction)stopAction:(id)sender {
    UIButton *btn = sender;
    if (btn.selected == 0) {
        [[Timer shareTimer]cancelTimer];
    }
    else{
        
        [[Timer shareTimer]startTimer];
        
    }
    btn.selected = !btn.selected;
    
    
}



#pragma mark - Time代理实现
-(void)TimerActionWithRefreshUI{
    
    //    [self action];
    __weak TimerViewController *weakSelf = self;
    
    if (  [Timer shareTimer].timeCount <= 0 ) {
        [[Timer shareTimer]cancelTimer];
        
    }else{
        NSInteger minutes =   [Timer shareTimer].timeCount  / 60 ;
        NSInteger seconds =  [Timer shareTimer].timeCount % 60;
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置界面的按钮显示 根据自己需求设置
            weakSelf.smRoundView.minProgress = minutes / 60.0;
            weakSelf.minutesLabel.text = [NSString stringWithFormat:@"%ld",minutes];
            
            if (seconds % 5 == 0) {
                 NSInteger count = [weakSelf.imageArr count];
               
                TimerModel *model = [weakSelf.imageArr objectAtIndex:arc4random()%count];
               
                UIColor *color = model.timerColor;
                
//                UIColor *color = [UIColor colorWithRed:(arc4random()%255)/255. green:(arc4random()%255)/255. blue:(arc4random()%255)/255. alpha:1];
                weakSelf.color = color;
                weakSelf.foodImgView.image = model.timerImg;
                weakSelf.bigRoundView.changeColor =  weakSelf.color;
                [weakSelf.bigRoundView setNeedsDisplay];
                weakSelf.smRoundView.changeColor =  weakSelf.color;
                weakSelf.pointView.changeColor =  weakSelf.color;
                [weakSelf.pointView setNeedsDisplay];
                weakSelf.minutesLabel.textColor = weakSelf.color;
                weakSelf.secondsLabel.textColor = weakSelf.color;
                [weakSelf.stopBtn setTitleColor:weakSelf.color forState:UIControlStateNormal];
                
                [weakSelf.cancelBtn setTitleColor:weakSelf.color forState:UIControlStateNormal];
                
            }
            if ([weakSelf.minutesLabel.text integerValue] < 10) {
                weakSelf.minutesLabel.text = [NSString stringWithFormat:@"0%@",weakSelf.minutesLabel.text];
            }
            
            
            //怎么解决,一定要在后面再次调用get方法才行
            //                NSLog(@"%@",weakSelf.minutesLabel);
            
            weakSelf.secondsLabel.text = [NSString stringWithFormat:@"%ld",seconds];
            if ([weakSelf.secondsLabel.text integerValue] < 10) {
                weakSelf.secondsLabel.text = [NSString stringWithFormat:@"0%@",weakSelf.secondsLabel.text];
            }
            [Timer shareTimer].timeCount -- ;
            
//            NSLog(@"~~~~%ld",[Timer shareTimer].timeCount % 60);
        });
        
    }
    
}
//刷新大圆的进度条
-(void)TimerActionWithBigRound{
    _smRoundView.progress = 1 - _progressCount / 60.0;
    
    if (_progressCount >= 60.0) {
        
        _progressCount = 0.0;
    }
    _progressCount = _progressCount + 0.1;
    
    
}
//取消按钮
- (IBAction)cancelAction:(id)sender {
    if ([Timer shareTimer].smRoundTimer) {
        [[Timer shareTimer]cancelTimer];
    }
    [self cancelTimer];

   
}
//取消倒计时
-(void)cancelTimer{
    self.color = [UIColor whiteColor];
    self.bigRoundView.changeColor =  self.color;
    [self.bigRoundView setNeedsDisplay];
    self.smRoundView.changeColor =  self.color;
    self.pointView.changeColor =  self.color;
    [self.pointView setNeedsDisplay];
    
    [self.startBtn setHidden:NO];
    [self.timeoutView setHidden:YES];
    [self.bigRoundView setHidden:YES];
    [self.startBtn setHidden:NO];
    self.countLabel.text = @"0";
    [self.countLabel.superview setHidden:NO];
    self.smRoundView.minProgress = 0.0;
    self.progressCount = 0,0;
    self.smRoundView.progress = 0.0;
    
}







-(UIButton *)addMinBtn{
    if (_addMinBtn == nil) {
        _addMinBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.countLabel.bounds.size.width, self.countLabel.bounds.size.height)];
        _addMinBtn.center = self.view.center;
        [_addMinBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_addMinBtn];
    }
    return _addMinBtn;
}

-(void)startTimer{
    
    __weak TimerViewController *weakSelf = self;
    
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        //        [self timerAction];
        
    });
    self.time = timer;
    dispatch_resume(timer);
    
    
    dispatch_source_t timer1 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer1, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer1, ^{
        
        if (  weakSelf.timeout <= 0 ) {
            [self cancelTimer];
            
        }else{
            NSInteger minutes =   weakSelf.timeout / 60;
            NSInteger seconds =   weakSelf.timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                weakSelf.smRoundView.minProgress = minutes / 60.0;
                weakSelf.minutesLabel.text = [NSString stringWithFormat:@"%ld",(long)minutes];
                
                if (seconds % 5 == 0) {
                    UIColor *color = [UIColor redColor];
//                    UIColor *color = [UIColor colorWithRed:(arc4random()%255)/255. green:(arc4random()%255)/255. blue:(arc4random()%255)/255. alpha:1];
                    weakSelf.color = color;
                    weakSelf.bigRoundView.changeColor =  weakSelf.color;
                    [weakSelf.bigRoundView setNeedsDisplay];
                    weakSelf.smRoundView.changeColor =  weakSelf.color;
                    weakSelf.pointView.changeColor =  weakSelf.color;
                    [weakSelf.pointView setNeedsDisplay];
                    weakSelf.minutesLabel.textColor = weakSelf.color;
                    weakSelf.secondsLabel.textColor = weakSelf.color;
                    [weakSelf.stopBtn setTitleColor:weakSelf.color forState:UIControlStateNormal];
                    
                    [weakSelf.cancelBtn setTitleColor:weakSelf.color forState:UIControlStateNormal];
                    
                }
                if ([weakSelf.minutesLabel.text integerValue] < 10) {
                    weakSelf.minutesLabel.text = [NSString stringWithFormat:@"0%@",weakSelf.minutesLabel.text];
                }
                
                
                //怎么解决,一定要在后面再次调用get方法才行
                //                NSLog(@"%@",weakSelf.minutesLabel);
                
                weakSelf.secondsLabel.text = [NSString stringWithFormat:@"%ld",(long)seconds];
                if ([weakSelf.secondsLabel.text integerValue] < 10) {
                    weakSelf.secondsLabel.text = [NSString stringWithFormat:@"0%@",weakSelf.secondsLabel.text];
                }
                
            });
            
        }
        
        
        
        weakSelf.timeout -- ;
        //        [self timerAction1];
    });
    self.time1 = timer1;
    dispatch_resume(timer1);
    
    
}


//计时,隐藏控件
-(void)action{
    
    
    [self.startBtn setHidden:YES];
    [self.timeoutView setHidden:NO];
    [self.bigRoundView setHidden:NO];
    [self.countLabel.superview setHidden:YES];
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addMinBtn];


    [self.foodImgView sd_setImageWithURL:[NSURL URLWithString:@"http://recipe.uniqlo.com/Recipe/Steps_Brian_Squash_Soup_03_320x504@2x.jpg"]];
    [self.foodImgView setContentMode:UIViewContentModeScaleAspectFit];
 
    
    
    [self.stopBtn setTitle:@"继续" forState:UIControlStateSelected];
    self.smRoundView.minBlock = ^(NSInteger min){
        
        self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)min];
    };
   
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];




}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [Timer shareTimer].delegate = self;
   
    [self.stopBtn setTitle:@"继续" forState:UIControlStateSelected];
    self.smRoundView.minBlock = ^(NSInteger min){
        
        self.countLabel.text = [NSString stringWithFormat:@"%ld",min];
    };
    
    self.imageArr = [NSMutableArray new];
    
    
    UIColor *color = RGBA(204, 106, 0, 1);
    
    NSString *food = [NSString stringWithFormat:@"Josef_Cabbage_Salad_"];
    
    UIColor *color1 = RGBA(197, 200, 84, 1);
    NSString *food1 = [NSString stringWithFormat:@"Kim_Broken_Pasta_"];
    
    
    UIColor *color2 = RGBA(92, 56, 98, 1);
    NSString *food2 = [NSString stringWithFormat:@"Josef_Greek_Yogurt_"];
    
    UIColor *color3 = RGBA(227, 181, 141, 1);
    NSString *food3 = [NSString stringWithFormat:@"Kuniko_Granita_"];
    
    UIColor *color4 = RGBA(225,138, 62, 1);
    NSString *food4 = [NSString stringWithFormat:@"Thomas_Posset_"];
    
    UIColor *color5 = RGBA(227, 164, 87, 1);
    NSString *food5 = [NSString stringWithFormat:@"Kuniko_Buckwheat_Soup_"];
    
    
    UIColor *color6 = RGBA(94, 120, 85, 1);
    NSString *food6 = [NSString stringWithFormat:@"Kim_Frisee_Salad_"];
    
    UIColor *color7 = RGBA(195, 210, 179, 1);
    NSString *food7 = [NSString stringWithFormat:@"Thomas_Bagna_Cauda_"];
    
    UIColor *color8 = RGBA(229, 177, 82, 1);
    NSString *food8 = [NSString stringWithFormat:@"Jamie_Halibut_"];
    
    
    UIColor *color9 = RGBA(86, 51, 60, 1);
    NSString *food9 = [NSString stringWithFormat:@"Kuniko_Miso_Steak_"];
    
    UIColor *color10 = RGBA(179, 200, 129, 1);
    NSString *food10 = [NSString stringWithFormat:@"Josef_Risotto_"];
    

    
    
    NSArray *colorArr = [NSArray arrayWithObjects:color,color1,color2,color3,color4,color5,color6,color7,color8,color9,color10, nil];
    NSArray *foodArr = [NSArray arrayWithObjects:food,food1,food2,food3,food4,food5,food6,food7,food8,food9,food10, nil];
    
//    
//    for (int i = 0 ; i < 11; i++) {
////                NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[[foodArr objectAtIndex:i],[colorArr objectAtIndex:i] ]forKeys:@[@"food",@"color"]];
//        UIImageView *imgeView = [UIImageView new];
//        [self.view addSubview:imgeView];
//        NSString *url = [NSString stringWithFormat:@"http://recipe.uniqlo.com/Recipe/Chef_%@320x504@2x.jpg",[foodArr objectAtIndex:i]];
//        
//        [imgeView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (image) {
//                TimerModel *model = [TimerModel new];
//                model.timerImg = image;
//                model.timerColor = [colorArr objectAtIndex:i];
//                [self.imageArr addObject:model];
//                NSLog(@"%ld",self.imageArr.count);
//            }
//            [imgeView removeFromSuperview];
//        }];
//
//    }
    for (int i = 0 ; i < 11; i++) {
        //                NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[[foodArr objectAtIndex:i],[colorArr objectAtIndex:i] ]forKeys:@[@"food",@"color"]];
        UIImageView *imgeView = [UIImageView new];
        [self.view addSubview:imgeView];
        NSString *url = [NSString stringWithFormat:@"http://recipe.uniqlo.com/Recipe/Dish_%@320x504@2x.jpg",[foodArr objectAtIndex:i]];
        
        [imgeView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                TimerModel *model = [TimerModel new];
                model.timerImg = image;
                model.timerColor = [colorArr objectAtIndex:i];
                [self.imageArr addObject:model];
                NSLog(@"%ld",self.imageArr.count);
            }
            [imgeView removeFromSuperview];
        }];
        
    }
    for (int i = 0 ; i < 11; i++) {
        //                NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[[foodArr objectAtIndex:i],[colorArr objectAtIndex:i] ]forKeys:@[@"food",@"color"]];
        for (int j = 0;  j < 5; j ++) {
            UIImageView *imgeView = [UIImageView new];
            [self.view addSubview:imgeView];
            NSString *url = [NSString stringWithFormat:@"http://recipe.uniqlo.com/Recipe/Steps_%@0%d_320x504@2x.jpg",[foodArr objectAtIndex:i],j];
            
            [imgeView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    TimerModel *model = [TimerModel new];
                    model.timerImg = image;
                    model.timerColor = [colorArr objectAtIndex:i];
                    [self.imageArr addObject:model];
                    NSLog(@"%ld",self.imageArr.count);
                }
                [imgeView removeFromSuperview];
            }];
        }
  
        
    }

    
    

}


-(void)btnAction{
    NSInteger min = [self.countLabel.text integerValue];
    min ++ ;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)min];
    if (min / 60 <= 1) {
        self.smRoundView.minProgress = min / 60.0;
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
