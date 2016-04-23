//
//  MaterialModel.h
//  早餐
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaterialModel : NSObject

@property(nonatomic,retain)NSString *name;//材料名
@property(nonatomic,retain)NSString *dosage;//材料数量

-(instancetype)initWithdic:(NSDictionary *)dic;

@end
