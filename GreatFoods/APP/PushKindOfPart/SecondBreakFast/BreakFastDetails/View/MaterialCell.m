//
//  MaterialCell.m
//  早餐
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import "MaterialCell.h"
#import "MaterialModel.h"
#import "DetailsPageController.h"

#import <UIView+SDAutoLayout.h>
#import <UITableView+SDAutoTableViewCellHeight.h>
@implementation MaterialCell


-(void)Material:(NSArray *)Material{
    
    NSLog(@"-*-*-*-*-*-*-*-*-*-%@",Material[0]);
}

-(void)setMateria:(NSArray *)Materia
{
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self LayoutUI];
    }
    return self;
}


-(void)LayoutUI
{
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 5, 18)];
    [view1 setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(23, 10, 100, 18)];
    [label1 setText:@"需要材料"];
    [label1 setFont:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:label1];
    
    
    for (int i = 0; i < _Materia.count; i++) {
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
        [self.contentView addSubview:label];
        
    }
    
    for (int i = 0; i < _Materia.count; i++) {
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
        [self.contentView addSubview:label];
    }
    
    for (int i = 0; i < _Materia.count; i++) {
        MaterialModel *model = _Materia[i];
        NSLog(@"%@:%@",model.name,model.dosage);
        
        UILabel *label = (UILabel *)[self viewWithTag:100+i];
        label.text = [NSString stringWithFormat:@"%@",model.name];
        
        UILabel *label1 = (UILabel *)[self viewWithTag:200+i];
        label1.text = model.dosage;
    }

}

-(void)MaterialString:(NSString *)materialstring
{
    _materialLabel.text = materialstring;
}

-(void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end
