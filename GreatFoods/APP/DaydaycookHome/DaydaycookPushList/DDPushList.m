//
//  DDPushList.m
//  美食类
//
//  Created by 夏浩文 on 16/4/19.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "DDPushList.h"
#import "SearchViewController.h"
#import "BreakFastViewController.h"
#import "MineViewController.h"
@implementation DDPushList

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)Time:(UIButton *)sender {

      [[self viewController].navigationController pushViewController:_timerVc animated:YES];
    
}
- (IBAction)breakfast:(UIButton *)sender {
    BreakFastViewController *breakFast = [BreakFastViewController new];
    [[self viewController].navigationController pushViewController:breakFast animated:YES];
}
- (IBAction)search:(UIButton *)sender {
    SearchViewController *search = [SearchViewController new];
    [[self viewController].navigationController pushViewController:search animated:YES];
}
- (IBAction)mine:(UIButton *)sender {
    MineViewController *mine = [MineViewController new];
    [[self viewController].navigationController pushViewController:mine animated:YES];
}

//从uiview中找到navigation
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
