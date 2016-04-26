//
//  MineCollextCollectionViewCell.m
//  美食类
//
//  Created by lynsea on 16/4/26.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "MineCollextCollectionViewCell.h"
#import "CollectModel.h"
#import <UIImageView+WebCache.h>

@implementation MineCollextCollectionViewCell
-(void)getModel:(CollectModel *)model
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"background-1"]];
    
    self.titleLabel.text = model.makeTitle;
    
}
- (void)awakeFromNib {
    // Initialization code
}

@end