//
//  AppDelegate.m
//  美食类
//
//  Created by 夏浩文 on 16/4/18.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "AppDelegate.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "DaydayHome.h"
#import "WHC_NavigationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //[storyBoard instantiateInitialViewController]
    
    
    
    [UMSocialData setAppKey:@"5720b91867e58efd09002f70"];
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx5b3ee5b4273bd51f" appSecret:@"8d2832b04d809ccb227b09633507cb0b" url:@"http://baidu.com"];
    
    
    
    
    WHC_NavigationController *rootNav = [[WHC_NavigationController alloc]initWithRootViewController:[storyBoard instantiateInitialViewController]];
    [rootNav.navigationBar setBackgroundColor:[UIColor clearColor]];
//
    [rootNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Zapfino" size:15.0] forKey:NSFontAttributeName]];
    
    self.window.rootViewController = rootNav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
