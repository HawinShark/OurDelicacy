//
//  GuideViewController.h
//  美食类
//
//  Created by 夏浩文 on 16/4/28.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController


/* 是否不是第一次*/
@property (nonatomic, assign) BOOL isMajor;

/* 切换root controller */
@property (nonatomic, copy)  void (^ExchangeController)();

@end