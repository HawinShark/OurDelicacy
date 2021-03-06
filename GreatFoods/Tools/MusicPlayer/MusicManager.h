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

/* avaudio*/
@property (nonatomic, retain) AVAudioPlayer *Aplayer;

-(instancetype)initWithMP3NAME;

//播放结束音乐
- (void)playerWithPath:(NSString *)path andType:(NSString *)type;

//播放m4a
- (void)playM4a;

- (void)play;

- (void)pause;

- (void)stop;

@end
