//
//  HeadViewCell.h
//  早餐
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headViewImage;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@property(nonatomic,retain) NSArray *abc;

@end
