//
//  StepOneModel.h
//  早餐
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StepOneModel : NSObject

@property(nonatomic,assign)NSInteger ordernum;//第几步
@property(nonatomic,retain)NSString *imageid;//拼接网址
@property(nonatomic,retain)NSString *details;//步骤说明

-(instancetype)initWithdic:(NSDictionary *)dic;

@end
