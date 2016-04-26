//
//  SearchListViewCell.m
//  美食类
//
//  Created by 夏浩文 on 16/4/25.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "SearchListViewCell.h"
#import <UIImageView+WebCache.h>
#import "DataBase.h"
#import "CollectModel.h"
@interface SearchListViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *Image;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *share;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (nonatomic,retain) CollectModel *model;


@end

@implementation SearchListViewCell

-(void)dealloc{
    
    
    
}
- (IBAction)zanAction:(UIButton *)sender {
    
    if (sender.selected == NO) {
        [[DataBase shareData]insertInfo:self.model];

    }
    else{
        [[DataBase shareData]deleteInfo:self.model.makeTitle];
        
    }
    
    sender.selected = !sender.selected;
}

-(void)GetModel:(DaydayCookData *)model{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [_Image sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        
    });
    
    
    _title.text = model.title;
    _share.text = [NSString stringWithFormat:@"%0.f" ,model.shareCount];
    _message.text = model.dataDescription;
    
    //判断是否已收藏
    self.ZanButton.selected = NO;
    [[DataBase shareData]openFmdb];
    NSMutableArray *titleArr = [[DataBase shareData]queryMakeTitle];
    for (NSString *str in titleArr) {
        if ([model.title isEqualToString:str]) {
            self.ZanButton.selected = YES;
        }
    }
    
    self.model = [[CollectModel alloc]init];
    self.model.makeTitle = model.title;
    self.model.bookId = model.dataIdentifier;
    self.model.imgUrl = model.imageUrl;
   
    
}

- (void)awakeFromNib {
    // Initialization code
    
    _Image.clipsToBounds = YES;
    _Image.center = self.contentView.center;
    _Image.contentMode = UIViewContentModeScaleAspectFill;
    _Image.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
}

@end
