//
//  Timer.h
//  美食类
//
//  Created by lynsea on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol TimerDelegate <NSObject>

-(void)TimerActionWithRefreshUI;
-(void)TimerActionWithBigRound;

@end

@interface Timer : NSObject
@property(nonatomic,assign)NSInteger timeCount;
@property(nonatomic,assign)id <TimerDelegate>delegate;
//计时器
@property(nonatomic,strong)dispatch_source_t smRoundTimer;
@property(nonatomic,strong)dispatch_source_t bigRoundtimer;
@property(nonatomic,assign)BOOL isTimer;
+(instancetype)shareTimer;
-(void)startTimer;
-(void)cancelTimer;


@end
