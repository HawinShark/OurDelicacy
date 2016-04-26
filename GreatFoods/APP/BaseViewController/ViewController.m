//
//  ViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/18.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
//    self.edgesForExtendedLayout = 0;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //毛玻璃
//    UIBlurEffect *effct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *effctView = [[UIVisualEffectView alloc]initWithEffect:effct];
//    effctView.frame = image.bounds;
//    
//    [image addSubview:effctView];
    
    self.DDdataArray = [NSMutableArray new];
    RefreshCurrentPage = 0;

        
}
//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//}










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
