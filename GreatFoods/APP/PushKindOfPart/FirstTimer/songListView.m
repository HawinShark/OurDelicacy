//
//  songListView.m
//  美食类
//
//  Created by lynsea on 16/4/23.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "songListView.h"

@implementation songListView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.playImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, H(self))];
        [self.playImgView setImage:[UIImage imageNamed:@"暂停.png"]];
        [self addSubview:self.playImgView];
        
        self.songView = [[UIView alloc]initWithFrame:CGRectMake(50, 0, W(self)- 50, H(self))];
        [self addSubview:self.songView];
        
        self.songLabel = [[UILabel alloc]initWithFrame:self.songView.frame];
        [self addSubview:self.songView];
        
        self.playBtn = [[UIButton alloc]initWithFrame:self.bounds];
        [self.playBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.playBtn];
//        [self.playBtn setBackgroundColor:[UIColor cyanColor]];
        
        
        
    }
    
    return self;
}

-(void)btnAction:(UIButton *)btn{
    
    
    NSLog(@"sssss");
    if (btn.selected == NO) {
        [self.playImgView setBackgroundColor:[UIColor clearColor]];
        [self.songView setBackgroundColor:[UIColor clearColor]];
        [self setBackgroundColor:[UIColor greenColor]];
        [self.playImgView setImage:[UIImage imageNamed:@"暂停1.png"]];
    }
    else{
        [self.playImgView setImage:[UIImage imageNamed:@"暂停.png"]];

        [self setColor:self.songNum];
        
        
    }
    
    btn.selected = !btn.selected;
    
    
}
-(void)setColor:(NSInteger)songNum{
    self.songNum = songNum;
    if (songNum % 2 == 0) {
        [self.playImgView setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
        [self.songView setBackgroundColor:[UIColor colorWithWhite:0 alpha:1]];
        
    }
    else{
        [self.songView setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
        [self.playImgView setBackgroundColor:[UIColor colorWithWhite:0 alpha:1]];
        
    }
    
    
}




@end
