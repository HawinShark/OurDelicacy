//
//  pointView.m
//  美食类
//
//  Created by lynsea on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "PointView.h"

@implementation PointView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)drawRect:(CGRect)rect{
    
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = CGRectMake(0, 0, 200, 200);
    
    replicator.backgroundColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:replicator];
    
    CALayer *indicator = [CALayer layer];
    
    //    indicator.transform = CATransform3DMakeScale(0, 0, 0);
    
    indicator.position = CGPointMake(100, 0);
    
    indicator.bounds = CGRectMake(0, 0, 5, 5);
    indicator.cornerRadius = 2.5;
    
    if (_changeColor) {
        indicator.backgroundColor = _changeColor.CGColor;
    }
    else{
        indicator.backgroundColor = [UIColor whiteColor].CGColor;
        
        
    }
    //    indicator.backgroundColor = [UIColor whiteColor].CGColor;
    
    [replicator addSublayer:indicator];
    
    
    int count = 60;
    
    // 设置子层次数
    replicator.instanceCount = count;
    
    // 设置子层动画延长时间
    //    replicator.instanceDelay = durtion / count;
    
    // 设置子层形变角度
    CGFloat angle = M_PI * 2 / count;
    replicator.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    
    
    
    CAReplicatorLayer *replicator1 = [CAReplicatorLayer layer];
    replicator1.frame = CGRectMake(0, 0, 200, 200);
    
    replicator1.backgroundColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:replicator1];
    
    CALayer *indicator1 = [CALayer layer];
    
    //    indicator.transform = CATransform3DMakeScale(0, 0, 0);
    
    indicator1.position = CGPointMake(100, 10);
    
    indicator1.bounds = CGRectMake(0, 0, 5, 20);
    //    indicator1.cornerRadius = 5;
    //    indicator1.backgroundColor = [UIColor whiteColor].CGColor;
    if (_changeColor) {
        indicator1.backgroundColor = _changeColor.CGColor;
    }
    else{
        indicator1.backgroundColor = [UIColor whiteColor].CGColor;
        
        
    }
    [replicator1 addSublayer:indicator1];
    
    int count1 = 4;
    
    // 设置子层次数
    replicator1.instanceCount = count1;
    
    // 设置子层形变角度
    CGFloat angle1 = M_PI * 2 / count1;
    replicator1.instanceTransform = CATransform3DMakeRotation(angle1, 0, 0, 1);
    
    
    
    
    CAReplicatorLayer *replicator2 = [CAReplicatorLayer layer];
    replicator2.frame = CGRectMake(0, 0, 200, 200);
    
    replicator2.backgroundColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:replicator2];
    
    CALayer *indicator2 = [CALayer layer];
    
    //    indicator.transform = CATransform3DMakeScale(0, 0, 0);
    
    indicator2.position = CGPointMake(100, 5);
    
    indicator2.bounds = CGRectMake(0, 0, 5, 10);
    //    indicator1.cornerRadius = 5;
    //    indicator2.backgroundColor = [UIColor blackColor].CGColor;
    if (_changeColor) {
        indicator2.backgroundColor = _changeColor.CGColor;
    }
    else{
        indicator2.backgroundColor = [UIColor whiteColor].CGColor;
        
        
    }
    [replicator2 addSublayer:indicator2];
    
    int count2 = 12;
    
    // 设置子层次数
    replicator2.instanceCount = count2;
    
    // 设置子层形变角度
    CGFloat angle2 = M_PI * 2 / count2;
    replicator2.instanceTransform = CATransform3DMakeRotation(angle2, 0, 0, 1);
    
    
    
}

@end
