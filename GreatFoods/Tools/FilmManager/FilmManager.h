//
//  FilmManager.h
//  美食类
//
//  Created by 夏浩文 on 16/4/23.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface FilmManager : UIView

/* item */
@property (nonatomic, retain) AVPlayerItem *item;

/* player */
@property (nonatomic, retain) AVPlayer *player;



-(instancetype)initWithFrame:(CGRect)frame WithUrl:(NSString *)str;

-(void)suspend;

@end
