//
//  songListView.h
//  美食类
//
//  Created by lynsea on 16/4/23.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface songListView : UIView
@property(nonatomic,retain)UIButton *playBtn;
@property(nonatomic,retain)UIImageView *playImgView;
@property(nonatomic,retain)UIView *songView;
@property(nonatomic,retain)UILabel *songLabel;
@property(nonatomic,assign)NSInteger songNum;

-(void)setColor:(NSInteger)songNum;
@end
