//
//  bigRoundView.m
//  美食类
//
//  Created by lynsea on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "BigRoundView.h"

@implementation BigRoundView
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 圆角矩形
    //   UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, 250, 250) cornerRadius:125];
    //
    //
    //    [[UIColor whiteColor]set];
    //    path1.lineWidth = 5;
    //    [path1 stroke];
    ////
    // 圆弧
    // Center：圆心
    // startAngle:弧度
    // clockwise:YES:顺时针 NO：逆时针
    
    // 扇形
    CGPoint center = CGPointMake(150, 150);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:100 startAngle:-M_PI endAngle:M_PI clockwise:YES];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:125 startAngle:-M_PI endAngle:M_PI clockwise:YES];//     添加一根线到圆心
    //    [path addLineToPoint:center];
    path.lineWidth = 5;
    path1.lineWidth = 5;
    
    if (_changeColor) {
        [_changeColor set];
    }
    else{
        [[UIColor whiteColor]set];
        
    }
    //     封闭路径，关闭路径：从路径的终点到起点
    //    [path closePath];
    [path stroke];
    [path1 stroke];
    
    
    // 填充：必须是一个完整的封闭路径,默认就会自动关闭路径
    //    [path fill];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
