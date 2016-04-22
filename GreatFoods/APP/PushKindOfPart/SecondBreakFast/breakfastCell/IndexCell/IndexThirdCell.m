//
//  IndexThirdCell.m
//  美食类
//
//  Created by 夏浩文 on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "IndexThirdCell.h"

#import <UIImageView+WebCache.h>
#import "UIImage+Extended.h"
@interface IndexThirdCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageone;
@property (weak, nonatomic) IBOutlet UIImageView *TransparencyOne;
@property (weak, nonatomic) IBOutlet UILabel *LabelOne;

@property (weak, nonatomic) IBOutlet UIImageView *imagetwo;
@property (weak, nonatomic) IBOutlet UIImageView *TransparencyTwo;
@property (weak, nonatomic) IBOutlet UILabel *LabelTwo;

@property (weak, nonatomic) IBOutlet UIImageView *imagethree;
@property (weak, nonatomic) IBOutlet UIImageView *TransparencyThree;
@property (weak, nonatomic) IBOutlet UILabel *LabelThree;

@property (weak, nonatomic) IBOutlet UIImageView *imagefour;
@property (weak, nonatomic) IBOutlet UIImageView *TransparencyFour;
@property (weak, nonatomic) IBOutlet UILabel *LabelFour;

@property (weak, nonatomic) IBOutlet UIImageView *imagefive;
@property (weak, nonatomic) IBOutlet UILabel *title;


@end





@implementation IndexThirdCell




-(void)Get:(List *)one two:(List *)two three:(List *)three four:(List *)four five:(List *)five
{
    
    [self.imageone sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",one.imageid]]];
    _LabelOne.text = one.name;
    
    [self.imagetwo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",two.imageid]]];
    _LabelOne.text = two.name;
    
    [self.imagethree sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",three.imageid]]];
    _LabelThree.text = three.name;
    
    [self.imagefour sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",four.imageid]]];
    _LabelFour.text = four.name;
    
    [self.imagefive sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m720",five.imageid]]];
    self.title.text = five.name;
    
    
    //裁剪
    self.imageone.image = [UIImage RecompressedImageFromImage:self.imageone.image];
    self.imagetwo.image = [UIImage RecompressedImageFromImage:self.imagetwo.image];
    self.imagethree.image = [UIImage RecompressedImageFromImage:self.imagethree.image];
    self.imagefour.image = [UIImage RecompressedImageFromImage:self.imagefour.image];
    self.imagefive.image = [UIImage RecompressedImageFromImage:self.imagefive.image];
    
    
}




- (void)awakeFromNib {
    _TransparencyOne.alpha = 0.3;
    _TransparencyTwo.alpha = 0.3;
    _TransparencyThree.alpha = 0.3;
    _TransparencyFour.alpha = 0.3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
