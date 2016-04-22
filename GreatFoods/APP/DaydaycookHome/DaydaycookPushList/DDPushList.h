//
//  DDPushList.h
//  美食类
//
//  Created by 夏浩文 on 16/4/19.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerViewController.h"
@interface DDPushList : UIView

@property (weak, nonatomic) IBOutlet UIButton *Timer;
@property (weak, nonatomic) IBOutlet UIButton *BreakFast;
@property (weak, nonatomic) IBOutlet UIButton *Search;
@property (weak, nonatomic) IBOutlet UIButton *Mine;

@property (nonatomic,strong) TimerViewController *timerVc;

@end
