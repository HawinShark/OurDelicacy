//
//  DDCLoopLayout.h
//  美食类
//
//  Created by 夏浩文 on 16/4/18.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCLoopLayout : UICollectionViewLayout


@property (nonatomic) IBInspectable CGFloat standardHeight;
@property (nonatomic) IBInspectable CGFloat focusHeight;
@property (nonatomic) IBInspectable CGFloat dragHeight;

-(void)setStandardHeight:(CGFloat)standardHeight;
@end
