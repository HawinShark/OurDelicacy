//
//  HeadViewModel.m
//  早餐
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import "HeadViewModel.h"

@implementation HeadViewModel

- (instancetype)initWithdic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

@end
