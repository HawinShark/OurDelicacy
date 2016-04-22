//
//  smRoundView.h
//  美食类
//
//  Created by lynsea on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^smRoundBlock)(NSInteger min);

@interface SmRoundView : UIView
@property(nonatomic,assign)CGFloat progress;
@property(nonatomic,assign)CGFloat minProgress;
@property (nonatomic, copy) smRoundBlock minBlock;
@property(nonatomic,strong)UIColor *changeColor;
@property(nonatomic,strong) NSMutableArray *btnArray;


@end
