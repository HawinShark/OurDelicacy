//
//  DDCollectCell.h
//  美食类
//
//  Created by 夏浩文 on 16/4/18.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DaydayCookData;
@interface DDCollectCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *BackGroundImage;

-(void)getModel:(DaydayCookData *)model;

@end
