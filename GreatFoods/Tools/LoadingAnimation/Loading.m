//
//  Loading.m
//  美食类
//
//  Created by 夏浩文 on 16/4/20.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "Loading.h"

@implementation Loading

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        self.backgroundColor = RGB(251, 246, 243);
        
        CAReplicatorLayer *superLayer = [CAReplicatorLayer layer];
        superLayer.frame              = CGRectMake(screen_width/4, (screen_height - screen_width/2)/2, screen_width/2, screen_width/2);
        
        [self.layer addSublayer:superLayer];
        CALayer *spot = [CALayer layer];
        
        spot.transform = CATransform3DMakeScale(0, 0, 0);
        spot.position = CGPointMake(self.bounds.size.width/2, 20);
        spot.bounds   = CGRectMake(0, 0, 10, 20);
        spot.backgroundColor = selectColor.CGColor;
        
        [superLayer addSublayer:spot];
        
        //设置缩放动画
        CABasicAnimation *changeAnimate = [CABasicAnimation  animation];
        changeAnimate.keyPath     = @"transform.scale";
        changeAnimate.fromValue   = @1;
        changeAnimate.toValue     = @0;//伪动画
        
        changeAnimate.repeatCount = MAXFLOAT;
        changeAnimate.duration    = 1;
        
        [spot addAnimation:changeAnimate forKey:nil];
        
        int count                    = 20;
        CGFloat angle                = M_PI / 10;
        //设置子层总数
        superLayer.instanceCount     = count;
        superLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
        
        superLayer.instanceDelay = (CGFloat)1 / 20;
        
        
        
        
        
        
        
        
    }
    return self;
}


@end
