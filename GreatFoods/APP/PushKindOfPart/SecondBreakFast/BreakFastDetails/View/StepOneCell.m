//
//  StepOneCell.m
//  早餐
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import "StepOneCell.h"

@implementation StepOneCell

- (void)awakeFromNib {
    
    _stepImage.contentMode = UIViewContentModeScaleAspectFill;
    _stepImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
