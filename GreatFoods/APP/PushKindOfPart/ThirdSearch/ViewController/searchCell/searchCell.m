//
//  searchCell.m
//  美食类
//
//  Created by 夏浩文 on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "searchCell.h"

#import "SearchData.h"
#import <UIImageView+WebCache.h>
@interface searchCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *maketime;
@property (weak, nonatomic) IBOutlet UILabel *watch;

@property (weak, nonatomic) IBOutlet UILabel *message;

@end


@implementation searchCell

- (void)awakeFromNib {
    //
    
    
    self.contentView.backgroundColor = RGBA(0, 0, 0, 0);
}


- (void)setModel:(SearchData *)model
{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        

        NSString *img = [model.imageUrl stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        [self.image sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:nil];
    });
    
    self.image.clipsToBounds = YES;
    self.image.center = self.contentView.center;
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    self.image.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    
    
    self.title.text = model.name;
    
    self.watch.text = [NSString stringWithFormat:@"%0.f",model.clickCount];
    self.maketime.text = model.maketime;
    self.message.text = model.dataDescription;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
