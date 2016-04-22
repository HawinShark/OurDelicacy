//
//  IndexFirstCell.m
//  美食类
//
//  Created by 夏浩文 on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "IndexFirstCell.h"
#import "List.h"
#import <UIImageView+WebCache.h>

#import "UIImage+Extended.h"
@interface IndexFirstCell ()


@property (weak, nonatomic) IBOutlet UIImageView *imageFirst;
@property (weak, nonatomic) IBOutlet UIImageView *TransparencyView;
@property (weak, nonatomic) IBOutlet UILabel *LabelFirst;

@property (weak, nonatomic) IBOutlet UIImageView *imageSecond;
@property (weak, nonatomic) IBOutlet UIImageView *TransparencyViewTwo;
@property (weak, nonatomic) IBOutlet UILabel *LabelSecond;

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleName;

@property (weak, nonatomic) IBOutlet UILabel *collect;
@property (weak, nonatomic) IBOutlet UILabel *zan;

@end


@implementation IndexFirstCell

-(void)getModel:(List *)one ModelTwo:(List *)two ModelThree:(List *)three
{
    [self.imageFirst sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",one.imageid]]];
    _LabelFirst.text = one.name;
    
    [self.imageSecond sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",two.imageid]]];
    _LabelSecond.text = two.name;
    
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",three.imageid]]];
    self.titleName.text = three.name;
    self.collect.text = three.collectCount;
    self.zan.text = three.likeCount;
    
    
    self.imageFirst.image = [UIImage RecompressedImageFromImage:self.imageFirst.image];
    self.imageSecond.image = [UIImage RecompressedImageFromImage:self.imageSecond.image];
    self.titleImage.image = [UIImage RecompressedImageFromImage:self.titleImage.image];
    

    
}

- (void)awakeFromNib {
    //
    
    _TransparencyView.alpha = 0.3;
    _TransparencyViewTwo.alpha = 0.3;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
    
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    CGPoint p = [self convertPoint:point toView:self.imageFirst];
    if ([self.imageFirst pointInside:p withEvent:event]) {
        NSLog(@"yeyeye");
         return self;
    }
    else{
        
        return [super hitTest:point withEvent:event];
    }
    
   
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
