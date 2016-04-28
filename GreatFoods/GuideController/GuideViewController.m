//
//  GuideViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/28.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()



@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.ScrollView.contentSize = CGSizeMake(screen_width * 3, screen_height);
    
    
    
    
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
