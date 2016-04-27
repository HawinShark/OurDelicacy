//
//  DDCollectCell.m
//  美食类
//
//  Created by 夏浩文 on 16/4/18.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "DDCollectCell.h"
#import "DaydayCookData.h"
#import "UIImage+Extended.h"

#import "FilmManager.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface DDCollectCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIView *overView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *CookTime;
@property (weak, nonatomic) IBOutlet UILabel *watch;
@property (weak, nonatomic) IBOutlet UILabel *share;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UIImageView *TV;

@property (retain, nonatomic)CAGradientLayer *gradientLayer;

@end

CGFloat featuredHeight = 280.0;
CGFloat standardHegiht = 100.0;
CGFloat minAlpha = 0.05;
CGFloat maxAlpha = 0.4;


@implementation DDCollectCell


-(BOOL)isPlay{
    if (!_isPlay) {
        _isPlay = NO;
    }
    return _isPlay;
}



-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    CGFloat delta = 1- (featuredHeight - CGRectGetHeight(self.frame)) / (featuredHeight - standardHegiht);
    
    CGFloat alpha = maxAlpha - (delta * (maxAlpha - minAlpha));
    
    self.overView.alpha = alpha;

    
    CGFloat scale = MAX(delta, 0.5);
    _title.transform = CGAffineTransformMakeScale(scale, scale);
    
    self.message.alpha = delta;
    self.dateView.alpha = delta - .35;
    
}

-(void)getModel:(DaydayCookData *)model{
    
    //裁图
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        [self.BackGroundImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"background-1"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //标题
            [self.title setText:model.title];
            [self.message setText:model.dataDescription];
            
            //日期
            NSArray *dateArray = [model.releaseDate componentsSeparatedByString:@"-"];
            [self.dateLabel setText:[NSString stringWithFormat:@"%@/%@",dateArray[1],dateArray[2]]];
            
            
            //第二轮loop
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //烹饪时间
                [self.CookTime setText:model.maketime];
                //点击次数
                [self.watch setText:[NSString stringWithFormat:@"%.0f",model.clickCount]];
                //分享
                [self.share setText:[NSString stringWithFormat:@"%.0f",model.shareCount]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (model.indexUrl.length > 0) {
                        self.TV.alpha = 1;
                    }else{
                        self.TV.alpha = 0;
                    }
                });
                
            });
            
        });
        
    });
    
    
    
//    self.BackGroundImage.image = [UIImage RecompressedImageFromImage:self.BackGroundImage.image];//此方法重绘吃内存,不能大量使用
    
    
    
    
    
    
}

- (void)jianbian{
    _gradientLayer            = [CAGradientLayer layer];
     _gradientLayer.frame  = CGRectMake(0, H(self.contentView)-50, W(self.contentView), 60);
    _gradientLayer.colors     = [NSArray arrayWithObjects:
                                 (id)[[UIColor clearColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor], nil,nil];
    _gradientLayer.startPoint = CGPointMake(0.5, 0.5);
    _gradientLayer.endPoint   = CGPointMake(1, 1);
    [self.BackGroundImage.layer addSublayer:_gradientLayer];
    
    
    
    self.BackGroundImage.clipsToBounds = YES;
    self.BackGroundImage.center = self.contentView.center;
    self.BackGroundImage.contentMode = UIViewContentModeScaleAspectFill;
    self.BackGroundImage.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
}



- (void)awakeFromNib {
    // Initialization code
    [self jianbian];
}










@end
