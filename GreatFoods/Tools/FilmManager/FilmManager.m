//
//  FilmManager.m
//  美食类
//
//  Created by 夏浩文 on 16/4/23.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "FilmManager.h"

#import <AFNetworking.h>
@interface FilmManager ()
{
    UIView *Progre;
    NSURLSessionDownloadTask * task;
}

@end

@implementation FilmManager

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (Class)layerClass
{
    return [AVPlayerLayer class];
}


- (instancetype)initWithFrame:(CGRect)frame WithUrl:(NSString *)str
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:str]) {
            
            NSURL *filePath = [documentsDirectoryURL URLByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] objectForKey:str]];
            
            if (filePath) {
                
                
                NSLog(@"%@",filePath);
                
                [self itemWithUrl:filePath.absoluteString];
                //
            }
        }else{
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                [self downloadRequestWithUrl:str];
            });
        }
    }
    return self;
}



- (void)downloadRequestWithUrl:(NSString *)urlStr{
    
    Progre = [[UIView alloc]initWithFrame:CGRectMake(-screen_width, 0, screen_width, H(self))];
    Progre.alpha           = 0.6;
    Progre.backgroundColor = [UIColor orangeColor];
    [self addSubview:Progre];
    [self bringSubviewToFront:Progre];//下载进度颜色
    
    NSString *fileUrl = urlStr;
    //
    fileUrl = [fileUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:fileUrl];
    
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    

    task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"进度 = %lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            Progre.frame = CGRectMake(-screen_width + screen_width * (1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount), 0, screen_width, H(self));
        });

        
    }
 destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //下载地址
        //        NSLog(@"默认下载地址 = %@",targetPath);
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"%@",filePath.absoluteString);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:.3 animations:^{
                Progre.alpha = 0;
                Progre = nil;
            }];
            
            [self itemWithUrl:filePath.absoluteString];
        });
        
        [[NSUserDefaults standardUserDefaults]setObject:response.suggestedFilename forKey:urlStr];
        
    }];
    
    [task resume];
    
    //    //创建请求
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //
    //    //创建会话
    //    NSURLSession *session = [NSURLSession sharedSession];
    //
    //    //创建下载任务，并且启动他；在非主线程中执行
    //    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    //
    //        NSLog(@"%@,%@",location,response);
    //
    //        /* 获取caches路径*/
    //        NSString *destinationDirection = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //        /* 文件地址*/
    //        NSString *filePath             = [destinationDirection stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",url]];
    //        /* 文件转移*/
    //        NSFileManager *manager         = [NSFileManager defaultManager];
    //        [manager moveItemAtPath:location.path toPath:filePath error:nil];
    //
    //        //销毁session
    //        [session invalidateAndCancel];
    //        NSLog(@"下载完成,已存入本地 --> %@",filePath);
    //    }];
    //    
    //    [downloadTask resume];
}



-(void)itemWithUrl:(NSString *)file{
    
    _item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:file]];
    
    _player = [AVPlayer playerWithPlayerItem:_item];
    
    
    [(AVPlayerLayer *)[self layer] setPlayer:_player];
    
    //填充模式
    [(AVPlayerLayer *)[self layer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [_player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}



-(void)playbackFinished:(NSNotification *)notification
{
    NSLog(@"播放完成");
    [_player pause];
    [_player seekToTime:CMTimeMakeWithSeconds(0, 1)];
    [_player play];
}


-(void)dealloc{
    NSLog(@"销毁");
    [_player pause];
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:self.player.currentItem];
    [task suspend];//销毁下载
}

@end
