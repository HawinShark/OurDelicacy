//
//  DetailsPageController.h
//  早餐
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetandHUB.h"

@protocol ShuZu <NSObject>//第一步,声明协议

-(void)getArray:(NSArray *)array;

@end


@interface DetailsPageController : NetandHUB

@property(nonatomic,assign)id<ShuZu>delegate;//第二步,声明代理人
-(void)ChuanZhi;

@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@property(nonatomic,retain)NSString *DetailsId;

@end
