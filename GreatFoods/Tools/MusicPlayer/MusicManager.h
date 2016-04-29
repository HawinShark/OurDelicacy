//
//  MusicManager.h
//  美食类
//
//  Created by 夏浩文 on 16/4/29.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicManager : NSObject <AVAudioPlayerDelegate>


/* player*/
@property (nonatomic, retain) AVPlayer *player;

-(instancetype)initWithMP3NAME;

- (void)play;

- (void)pause;

- (void)stop;

@end
