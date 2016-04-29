//
//  BreakfastCell.m
//  美食类
//
//  Created by lanou on 16/4/28.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "BreakfastCell.h"

#import "CollectModel.h"
#import <UIImageView+WebCache.h>
@interface BreakfastCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageid;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *authorimageid;
@property (weak, nonatomic) IBOutlet UILabel *authorname;

@property(nonatomic,retain) CollectModel *collextModel;
@end

@implementation BreakfastCell

-(void)AcquireModel:(List *)model{
    
//    [_imageid sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",model.imageid] placeholderImage:(UIImage *)]];
    
    NSString *string = [NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",model.imageid];
    NSURL *url = [NSURL URLWithString:string];
    [_imageid sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    _name.text = model.name;
    [_authorimageid sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",model.authorimageid]]];
    _authorname.text = model.authorname;
}

- (void)awakeFromNib {
    
    _imageid.contentMode = UIViewContentModeScaleAspectFill;
    _imageid.clipsToBounds = YES;
    
}

//收藏
- (IBAction)collect:(id)sender {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
