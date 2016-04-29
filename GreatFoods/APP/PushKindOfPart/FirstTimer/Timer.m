//
//  Timer.m
//  美食类
//
//  Created by lynsea on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "Timer.h"

#import <AVFoundation/AVFoundation.h>
@interface Timer ()

@end


@implementation Timer
+(instancetype)shareTimer
{
    static Timer *timer = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        timer = [[Timer alloc]init];
        
    });
    
    
    return timer;
}
//开启倒计时
-(void)startTimer{
    
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        [self handleBigRoundTimerAction];
        
    });
    self.smRoundTimer = timer;
    dispatch_resume(timer);
    
    
    dispatch_source_t timer1 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer1, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer1, ^{
        [self handleSmRoundTimerAction];
//        NSLog(@"timeCount  == %ld",self.timeCount);
        
    });
    
    self.bigRoundtimer = timer1;
    dispatch_resume(timer1);
    
}

//暂停倒计时
-(void)cancelTimer{
    
    NSLog(@"cancel timer");
    dispatch_source_cancel(self.smRoundTimer);
    self.smRoundTimer = nil;
    dispatch_source_cancel(self.bigRoundtimer);
    self.bigRoundtimer = nil;
    
}
//取消倒计时

#pragma mark -- 定时器执行的方法
//大圆执行的方法
-(void)handleBigRoundTimerAction{
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(TimerActionWithBigRound)]) {
        [self.delegate TimerActionWithBigRound];
    }
    
}

-(void)handleSmRoundTimerAction{
    
    
    //判断代理是否为空,代理能否响应对应的方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(TimerActionWithRefreshUI)]) {
        [self.delegate TimerActionWithRefreshUI];
    }
    
}
@end
