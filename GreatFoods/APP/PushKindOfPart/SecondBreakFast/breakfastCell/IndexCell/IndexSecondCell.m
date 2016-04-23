//
//  IndexSecondCell.m
//  美食类
//
//  Created by 夏浩文 on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "IndexSecondCell.h"

#import <UIImageView+WebCache.h>
#import "UIImage+Extended.h"
@interface IndexSecondCell ()

    // your IB

@property (weak, nonatomic) IBOutlet UIImageView *image;


@end


@implementation IndexSecondCell



-(void)Get:(List *)model{

    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",model.imageid]]];
       
    });
    
    
    //裁剪
    self.image = [self MASK:self.image];

    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}









- (UIImageView *)MASK:(UIImageView *)image{
    image.clipsToBounds    = YES;
    image.center           = self.contentView.center;
    image.contentMode      = UIViewContentModeScaleAspectFill;
    image.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    return image;
}


@end
