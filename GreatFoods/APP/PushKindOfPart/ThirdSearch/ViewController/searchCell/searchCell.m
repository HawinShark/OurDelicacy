//
//  searchCell.m
//  美食类
//
//  Created by 夏浩文 on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "searchCell.h"

#import "SearchData.h"
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
    
    
    self.contentView.backgroundColor = [UIColor clearColor];
}


- (void)setModel:(SearchData *)model
{
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
