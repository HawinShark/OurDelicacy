//
//  MineCollextCollectionViewCell.h
//  美食类
//
//  Created by lynsea on 16/4/26.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectModel;
@interface MineCollextCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
-(void)getModel:(CollectModel *)model;
@end
