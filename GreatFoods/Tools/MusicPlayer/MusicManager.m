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
        [self playerWithPath:_musicArray[arcNum] andType:@"mp3"];
    }
    return self;
}

-(AVPlayer *)player{
    if (!_player) {
        _player = [[AVPlayer alloc]init];
    }
    return _player;
}

- (void)playerWithPath:(NSString *)path andType:(NSString *)type
{
    NSURL *mp3Url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@.%@",path,type] withExtension:nil];
    NSLog(@"%@",mp3Url.absoluteString);
    
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
    
    [self playerWithPath:_musicArray[arcNum] andType:@"mp3"];
}


- (void)playM4a:(NSString *)name{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"m4a"];
    
    self.Aplayer = [[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfFile:path] error:nil];
    
    self.Aplayer.numberOfLoops = 1;
    
    self.Aplayer.volume = 1.0;
    
    [self.Aplayer play];
}


- (void)play{
    [_player play];
}

- (void)pause{
    [_player pause];
}

- (void)stop{
    _player.rate = 0.0;
    if (_Aplayer) {
        [_Aplayer stop];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
