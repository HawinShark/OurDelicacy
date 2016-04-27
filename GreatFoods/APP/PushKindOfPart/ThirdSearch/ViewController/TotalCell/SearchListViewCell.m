//
//  SearchListViewCell.m
//  美食类
//
//  Created by 夏浩文 on 16/4/25.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "SearchListViewCell.h"
#import <UIImageView+WebCache.h>
#import <OpinionzAlertView.h>

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
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏成功" message:@"已加入收藏\n快进入我的收藏里查看吧~" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [[self viewController] presentViewController:alert animated:YES completion:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"取消成功" message:@"已取消收藏" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [[self viewController] presentViewController:alert animated:YES completion:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        
    }
    
    sender.selected = !sender.selected;
}

-(void)GetModel:(DaydayCookData *)model{

    
    
        
        //判断是否已收藏
    NSMutableArray *titleArr = [[DataBase shareData]queryMakeTitle];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_Image sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
            
            _title.text = model.title;
            _share.text = [NSString stringWithFormat:@"%0.f" ,model.shareCount];
            _message.text = model.dataDescription;
            
            //收藏
            self.ZanButton.selected = NO;
            for (NSString *str in titleArr) {
                if ([model.title isEqualToString:str]) {
                    self.ZanButton.selected = YES;
                }
            }
            
            self.model = [[CollectModel alloc]init];
            self.model.makeTitle = model.title;
            self.model.bookId = model.dataIdentifier;
            self.model.imgUrl = model.imageUrl;
        });
        
    });
    
    
   
   
    
}

- (void)awakeFromNib {
    // Initialization code
    
    _Image.clipsToBounds = YES;
    _Image.center = self.contentView.center;
    _Image.contentMode = UIViewContentModeScaleAspectFill;
    _Image.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
}


//从uiview中找到navigation
- (UIViewController*)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
