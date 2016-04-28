//
//  smRoundView.m
//  美食类
//
//  Created by lynsea on 16/4/21.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "SmRoundView.h"
#import "WHC_NavigationController.h"


NSInteger count;
@implementation SmRoundView

-(void)awakeFromNib{
    count = 0 ;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (UIButton *btn in _btnArray) {
        CGPoint p = [self convertPoint:point toView:btn];
        if ([btn pointInside:p withEvent:event]) {
            [self btnaction:btn];
            
        }
    }
    
    
    
    
    
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    for (UIButton *btn in _btnArray) {
        CGPoint p = [self convertPoint:point toView:btn];
        if ([btn pointInside:p withEvent:event]) {
            [self btnaction:btn];
            
//            WHC_NavigationController *nav = (WHC_NavigationController*)[self viewController].navigationController;
//            nav.panGesture.enabled = NO;
            
            
            
            return self;
            
        }
        
        
    }
    CGPoint p1 = [self convertPoint:p1 toView:self.superview];
    
    if ([self pointInside:p1 withEvent:event]) {
//        WHC_NavigationController *nav = (WHC_NavigationController*)[self viewController].navigationController;
//
//        nav.panGesture.enabled = YES;
//        
        [[self viewController] dismissViewControllerAnimated:YES completion:nil];
        
    }
   
    
    
    return [super hitTest:point withEvent:event];
}
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

-(void)setMinProgress:(CGFloat)minProgress{
    _minProgress = minProgress;
    
    [self setNeedsDisplay];
    NSNumber *num = @(_minProgress * 60);
    NSInteger min = [num integerValue];
    self.minBlock(min);
    
    
}
-(void)drawRect:(CGRect)rect{
    
    
    CGPoint center = CGPointMake(150, 150);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:100 startAngle:-M_PI_2 endAngle:-M_PI_2 + _minProgress * M_PI * 2 clockwise:YES];
    path.lineWidth = 5;
    
    if (_changeColor) {
        [_changeColor set];
    }
    else{
        [[UIColor whiteColor]set];
        
    }
    [path stroke];
    
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:125 startAngle:-M_PI_2 endAngle:(-M_PI_2 + _progress * M_PI * 2)  clockwise:YES];
    path1.lineWidth = 5;
    
    if (_changeColor) {
        [_changeColor set];
    }
    else{
        [[UIColor whiteColor]set];
        
    }
    [path1 stroke];
    
    
    
    CGFloat btnW = 2 * M_PI * 100 /60;
    
    
    if (count == 0) {
        
        _btnArray = [[NSMutableArray alloc]init];
        for ( int i = 0 ; i < 60 ; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.layer.anchorPoint = CGPointMake(0, 1);
            //
            btn.bounds = CGRectMake(0, 0, btnW, 100);
            btn.layer.position = CGPointMake(150, 150);
            //            btn.backgroundColor = [UIColor redColor];
            CGFloat radion =  2 * M_PI / 60 * i  ;
            btn.transform = CGAffineTransformMakeRotation(radion);
            btn.tag = 100 + i ;
            [self addSubview:btn];
            [_btnArray addObject:btn];
            //
            [btn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
        }
        count ++;
        
    }
    
}

-(void)btnaction:(UIButton *)button{
    
    self.minProgress = (button.tag - 100) / 60.0;
    
}








////
- (UIViewController*)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


@end
