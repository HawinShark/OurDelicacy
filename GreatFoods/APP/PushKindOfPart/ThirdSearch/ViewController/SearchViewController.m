//
//  SearchViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/20.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomSearchBar.h"
#import "SearchNextViewController.h"
#import "WHC_NavigationController.h"
@interface SearchViewController ()
{
    WHC_NavigationController *SearchNav;
}
@property(nonatomic,retain) SearchNextViewController *controller;

@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    
    [self buildCustomSearch];
    
}











#pragma mark- 创建自定义search

- (void) buildCustomSearch
{
    //image
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_width * (3.0/4.0))];
    image.contentMode  = UIViewContentModeScaleAspectFill;
    [image setImage:[UIImage imageNamed:@"background-6"]];
    [self.view addSubview:image];
    
    //search
    CustomSearchBar *search = [[CustomSearchBar alloc]initWithFrame:CGRectMake(40, screen_width * 0.55, screen_width - 80, 40)];
    [search getBlockFromOutSpace:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    
    
    
    
    //当按下return
    [search getClickFromReturn:^(NSString *str) {
        
        //
        [self modal];
        
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        self.controller.name = str;
        
        //跳转
        [self ModelToNext];
        
        
    }];
    
    [self.view addSubview:search];
}










- (void)modal{
    _controller = [[SearchNextViewController alloc] init];
    _controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    SearchNav = [[WHC_NavigationController alloc]initWithRootViewController:_controller];
}






- (void)ModelToNext{
    if (IOS_VERSION >= 8.0) {
        
        
        _controller.providesPresentationContextTransitionStyle = YES;
        _controller.definesPresentationContext = YES;
        _controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:SearchNav animated:YES completion:nil];
        
    } else {
        
        
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:SearchNav animated:NO completion:nil];
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
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
