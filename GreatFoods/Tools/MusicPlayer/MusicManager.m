//
//  MusicManager.m
//  美食类
//
//  Created by 夏浩文 on 16/4/29.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "MusicManager.h"


@interface MusicManager ()

{
    NSInteger arcNum;
}

/* 歌曲数组*/
@property (nonatomic, retain) NSMutableArray *musicArray;

@end


@implementation MusicManager



- (instancetype)initWithMP3NAME
{
    self = [super init];
    if (self) {
        
        //添加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEndTimeNotification:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
        self.musicArray = [NSMutableArray array];
        
        for (int i = 0; i < 10; i++) {
            NSString *name = [NSString stringWithFormat:@"UNI%d",i];
            [_musicArray addObject:name];
        }
        
        arcNum = arc4random_uniform(9);
        [self playerWithPath:_musicArray[arcNum]];
    }
    return self;
}

-(AVPlayer *)player{
    if (!_player) {
        _player = [[AVPlayer alloc]init];
    }
    return _player;
}

- (void)playerWithPath:(NSString *)path
{
    NSURL *mp3Url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@.mp3",path] withExtension:nil];
    
    
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:mp3Url];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    [self.player play];
}

- (void)handleEndTimeNotification:(NSNotification *)sender
{
    arcNum++;
    if (arcNum == 9) {
        arcNum = 0;
    }
    
    NSLog(@"%ld",arcNum);
    
    [self playerWithPath:_musicArray[arcNum]];
}


- (void)play{
    [_player play];
}

- (void)pause{
    [_player pause];
}

- (void)stop{
    _player.rate = 0.0;
}

@end
