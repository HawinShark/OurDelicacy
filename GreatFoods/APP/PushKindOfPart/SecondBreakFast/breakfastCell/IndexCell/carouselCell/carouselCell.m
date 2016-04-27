//
//  carouselCell.m
//  美食类
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "carouselCell.h"
#import <BHInfiniteScrollView.h>
#import <UIImage+MultiFormat.h>
@interface carouselCell ()<BHInfiniteScrollViewDelegate>
{
    BHInfiniteScrollView *infinr;
}
@end

@implementation carouselCell

-(void)setCarouselArray:(NSArray *)carouselArray
{
    
    NSMutableArray *carouselImages = [NSMutableArray array];
    
    NSMutableArray *tts = [NSMutableArray array];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (int i = 0; i < 5; i++) {
            [tts addObject:self.titles[i]];
        }
        
        for (int i = 0; i < 5; i++) {
        
            NSString *str = [NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",carouselArray[i]] ;
            UIImage *image = [UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
            
            [carouselImages addObject:image];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self buildInfir];
            
            [infinr setImagesArray:carouselImages];
            
            //加标题
            [infinr setTitlesArray:tts];
            
        });
    });
    
    
}



- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index
{
    [self.delegate infiniteScrollViewdidSelectItemAtIndex:index];
}



- (void)buildInfir{
    UIImage *place = [UIImage imageNamed:@"background-2"];
    infinr = [[BHInfiniteScrollView alloc]initWithFrame:self.contentView.bounds];
    infinr.delegate = self;
    [infinr setPlaceholderImage:place];
    
    [self.contentView addSubview:infinr];
    
    infinr.contentMode = UIViewContentModeScaleAspectFill;
    
    infinr.scrollDirection = BHInfiniteScrollViewScrollDirectionHorizontal;
    infinr.pageControlAlignmentH = BHInfiniteScrollViewPageControlAlignHorizontalRight;
    infinr.pageViewContentMode = UIViewContentModeRedraw;
    
    infinr.dotColor = [UIColor whiteColor];
    infinr.selectedDotColor = RGB(159, 169, 171);
    infinr.dotSpacing = 3;
    infinr.dotSize = 7;
    infinr.selectedDotSize = 8;
    infinr.dotShadowBlur = 2;
    
    infinr.pageControlAlignmentOffset = CGSizeMake(0, 3);
    
    //文字
    infinr.titleView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    infinr.titleView.textColor = [UIColor whiteColor];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
