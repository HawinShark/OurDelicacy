//
//  NetandHUB.h
//  美食类
//
//  Created by 夏浩文 on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetandHUB : UIViewController


// 显示菊花效果
-(void)showHudInViewhint:(NSString *)string;

// 隐藏菊花
-(void)showhide;

// 显示提示框
-(void)showHint:(NSString *)string;

// 判断网络状态
-(BOOL)isNetWork;



@end
