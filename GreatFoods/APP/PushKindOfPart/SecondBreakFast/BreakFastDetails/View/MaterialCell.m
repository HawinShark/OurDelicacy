//
//  MaterialCell.m
//  早餐
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import "MaterialCell.h"
#import "MaterialModel.h"

@implementation MaterialCell





- (void) build{
    for (int i = 0; i < _abc.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20*i+38, 150, 20)];
        label.tag = 100+i;
        
        if (label.tag%2 == 1)
        {
            [label setBackgroundColor:[UIColor whiteColor]];
        }else
        {
            [label setBackgroundColor:[UIColor colorWithRed:229/255. green:229/255. blue:229/255. alpha:1]];
        }
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        
    }
    
    for (int i = 0; i < _abc.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(160, 20*i+38, [UIScreen mainScreen].bounds.size.width-20-150, 20)];
        label.tag = 200+i;
        
        if (label.tag%2 == 1)
        {
            [label setBackgroundColor:[UIColor whiteColor]];
        }else
        {
            [label setBackgroundColor:[UIColor colorWithRed:229/255. green:229/255. blue:229/255. alpha:1]];
        }
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithRed:123/255. green:123/255. blue:123/255. alpha:1];
        [self addSubview:label];
        
    }
    
    for (int i = 0; i < _abc.count; i++) {
        MaterialModel *model = _abc[i];
        
        UILabel *label = (UILabel *)[self viewWithTag:100+i];
        label.text = [NSString stringWithFormat:@"%@",model.name];
        
        UILabel *label1 = (UILabel *)[self viewWithTag:200+i];
        label1.text = model.dosage;
    }
    
    ///
    UILabel *label = self.subviews.lastObject;
    self.constantheight.constant = CGRectGetMaxY(label.frame) - 25;
}

-(void)setAbc:(NSArray *)abc
{
    [self build];
//    __weak typeof(self)weakSelf = self;
//    [self setReload:^{
//        [weakSelf build];
//    }];
    
}




- (void)awakeFromNib {
    
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
