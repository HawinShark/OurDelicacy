//
//  HeadViewCell.h
//  早餐
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import <UIKit/UIKit.h>

//回传image到VC
typedef void (^HeadViewCellBlock)(UIImage *image);
@interface HeadViewCell : UITableViewCell




@property (nonatomic,copy) HeadViewCellBlock imageBlock;
@property (weak, nonatomic) IBOutlet UIImageView *headViewImage;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@property(nonatomic,retain) NSArray *abc;

@end
