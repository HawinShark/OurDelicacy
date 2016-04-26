//
//  SearchListViewCell.h
//  美食类
//
//  Created by 夏浩文 on 16/4/25.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaydayCookData.h"
@interface SearchListViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *ZanButton;

-(void)GetModel:(DaydayCookData *)model;

@end
