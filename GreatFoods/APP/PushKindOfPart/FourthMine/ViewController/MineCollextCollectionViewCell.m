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

-(void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    self.selectView.hidden = !selected;
    
    
    
}
-(void)getModel:(CollectModel *)model
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"GGIcon"]];
    NSLog(@"%@",model.imgUrl);
    
    self.titleLabel.text = model.makeTitle;

}
- (void)awakeFromNib {
    // Initialization code
}

@end
