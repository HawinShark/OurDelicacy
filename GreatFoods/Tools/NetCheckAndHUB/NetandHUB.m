//
//  NetandHUB.m
//  美食类
//
//  Created by 夏浩文 on 16/4/22.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "NetandHUB.h"

#import <MBProgressHUD.h>
#import <Reachability.h>
@interface NetandHUB ()

@end

@implementation NetandHUB



- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    
}

//菊花转圈圈
-(void)showHudInViewhint:(NSString *)string{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:view];
    HUD.labelText = string;
    HUD.tag = 1000;
    [view addSubview:HUD];
    [HUD show:YES];
}

//隐藏菊花
-(void)showhide{
    //获取所有子视图
    NSArray *array = [[UIApplication sharedApplication].delegate window].subviews;
    for (UIView *view in array) {
        if (view.tag == 1000) {
            [view removeFromSuperview];
        }
    }
}

//显示提示框
-(void)showHint:(NSString *)string{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = string;
    //设置显示的类型
    hud.mode = MBProgressHUDModeText;
    //设置显示的位置(距离最底下)
    hud.yOffset = 150.f;
    [self showhide];
    [hud hide:YES afterDelay:2];
}

-(BOOL)isNetWork{
    BOOL isNetWork = NO;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
            [self showHint:@"当前没有网络"];
            break;
        case ReachableViaWiFi:
            isNetWork = YES;
            break;
        case ReachableViaWWAN:
            isNetWork = YES;
            break;
        default:
            break;
    }
    return isNetWork;
}



-(BOOL)isWIFI{
    BOOL isWWAN = NO;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([reachability currentReachabilityStatus] == ReachableViaWiFi) {
        isWWAN = YES;
    }
    return isWWAN;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
