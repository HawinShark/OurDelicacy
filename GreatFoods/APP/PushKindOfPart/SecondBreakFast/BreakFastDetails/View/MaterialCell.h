//
//  MaterialCell.h
//  早餐
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialModel.h"

@interface MaterialCell : UITableViewCell

@property(nonatomic,retain) NSArray *Materia;
@property (weak, nonatomic) IBOutlet UILabel *materialLabel;

-(void)Material:(NSArray *)Material;

-(void)MaterialString:(NSString *)materialstring;

@end
