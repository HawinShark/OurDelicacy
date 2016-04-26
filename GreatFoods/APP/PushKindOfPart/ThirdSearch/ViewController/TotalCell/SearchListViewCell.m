//
//  SearchListViewCell.m
//  美食类
//
//  Created by 夏浩文 on 16/4/25.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "SearchListViewCell.h"
#import <UIImageView+WebCache.h>
@interface SearchListViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *Image;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *watch;
@property (weak, nonatomic) IBOutlet UILabel *share;
@property (weak, nonatomic) IBOutlet UILabel *message;

@end

@implementation SearchListViewCell


-(void)GetModel:(DaydayCookData *)model{

    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [_Image sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        
    });
    
    
    _title.text = model.title;
    _watch.text = [NSString stringWithFormat:@"%0.f" ,model.clickCount];
    _share.text = [NSString stringWithFormat:@"%0.f" ,model.shareCount];
    _message.text = model.dataDescription;
}

- (void)awakeFromNib {
    // Initialization code
    
    _Image.clipsToBounds = YES;
    _Image.center = self.contentView.center;
    _Image.contentMode = UIViewContentModeScaleAspectFill;
    _Image.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
}

@end
