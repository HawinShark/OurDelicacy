//
//  IndexSecondCell.m
//  美食类
//
//  Created by 夏浩文 on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "IndexSecondCell.h"

#import "UIImage+Extended.h"
#import <UIImageView+WebCache.h>
@interface IndexSecondCell ()

    // your IB

@property (weak, nonatomic) IBOutlet UIImageView *image;


@end


@implementation IndexSecondCell



-(void)Get:(List *)model{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",model.imageid]]];
       
    });
    
    _image.contentMode = UIViewContentModeScaleAspectFill;
    _image.clipsToBounds = YES;
    
//    //裁剪
//    self.image = [self MASK:self.image];
    
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


//- (UIImageView *)MASK:(UIImageView *)image{
//    image.clipsToBounds    = YES;
//    image.center           = self.contentView.center;
//    image.contentMode      = UIViewContentModeScaleAspectFill;
//    image.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//    return image;
//}


@end
