//
//  HeadViewCell.m
//  早餐
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import "HeadViewCell.h"
#import "HeadViewModel.h"

#import "UIImage+Extended.h"
#import "UIImageView+WebCache.h"
@implementation HeadViewCell

-(void)setAbc:(NSArray *)abc
{
    for (int i = 0; i < abc.count; i++) {
        HeadViewModel *model = abc[i];
        [_headViewImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",model.imageid]]];
        _headLabel.text = model.name;
    }
    
    _headViewImage.contentMode = UIViewContentModeScaleAspectFill;
    _headViewImage.clipsToBounds = YES;
}



- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
