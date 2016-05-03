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
#import "DataBase.h"
@interface BreakfastCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageid;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *authorimageid;
@property (weak, nonatomic) IBOutlet UILabel *authorname;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property(nonatomic,retain) CollectModel *collectModel;
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
    
    
    //判断是否已收藏
    [[DataBase shareData]openFmdb];
    NSMutableArray *titleArr = [[DataBase shareData]queryMakeTitle];
    //收藏
    self.collectBtn.selected = NO;
    for (NSString *str in titleArr) {
        if ([model.name isEqualToString:str]) {
            self.collectBtn.selected = YES;
        }
    }
    
    
    
    //接收model
    self.collectModel = [CollectModel new];
    self.collectModel.imgUrl = [NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",model.imageid];
    self.collectModel.makeTitle = model.name;
    self.collectModel.bookId = [model.listIdentifier integerValue];
    self.collectModel.VcName = @"BreakFast";
    
}

- (void)awakeFromNib {
    
    _imageid.contentMode = UIViewContentModeScaleAspectFill;
    _imageid.clipsToBounds = YES;
    
}

//收藏
- (IBAction)collect:(UIButton *)sender {
    if (sender.selected == NO) {
        [[DataBase shareData]insertInfo:self.collectModel];
        
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
