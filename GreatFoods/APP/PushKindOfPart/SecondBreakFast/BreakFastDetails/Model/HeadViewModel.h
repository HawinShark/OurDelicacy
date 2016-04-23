//
//  HeadViewModel.h
//  早餐
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadViewModel : NSObject

@property(nonatomic,retain)NSString *imageid;
@property(nonatomic,retain)NSString *name;

-(instancetype)initWithdic:(NSDictionary *)dic;

@end
