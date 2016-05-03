//
//  AppDelegate.m
//  美食类
//
//  Created by 夏浩文 on 16/4/18.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "DaydayHome.h"
#import "WHC_NavigationController.h"
#import "TimerViewController.h"
@interface AppDelegate ()

/* timer */
@property (nonatomic, retain) TimerViewController *timer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //如果第一次运行
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Guide"]) {
        
        GuideViewController *guide = [[GuideViewController alloc]init];
        
        [_window setRootViewController:guide];
        
        [guide setExchangeController:^{
            
            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            //[storyBoard instantiateInitialViewController]
            
            
            WHC_NavigationController *rootNav = [[WHC_NavigationController alloc]initWithRootViewController:[storyBoard instantiateInitialViewController]];
            [rootNav.navigationBar setBackgroundColor:[UIColor clearColor]];
            //
            [rootNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Zapfino" size:15.0] forKey:NSFontAttributeName]];
            
            //        rootNav.navigationItem
            
            self.window.rootViewController = rootNav;
            
            //注册本地通知
            [self registerLocalNotification];
            
        }];
    }else //不出引导图了
    {
        UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        WHC_NavigationController *rootNav = [[WHC_NavigationController alloc]initWithRootViewController:[storyBoard instantiateInitialViewController]];
        [rootNav.navigationBar setBackgroundColor:[UIColor clearColor]];
        //
        [rootNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Zapfino" size:15.0] forKey:NSFontAttributeName]];
        
        //        rootNav.navigationItem
        
        self.window.rootViewController = rootNav;
        
        //注册本地通知
        [self registerLocalNotification];
    }
    
    
    
    
        [UMSocialData setAppKey:@"5720b91867e58efd09002f70"];
        //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
        [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
        
        
        //设置微信AppId、appSecret，分享url
        [UMSocialWechatHandler setWXAppId:@"wx5b3ee5b4273bd51f" appSecret:@"8d2832b04d809ccb227b09633507cb0b" url:@"http://baidu.com"];
    
        
    
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

#pragma mark- 分享

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}



#pragma mark- 本地推送

- (void)registerLocalNotification
{
    //@"知道了" -- > 创建消息上面要添加的动作
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc]init];
    
    action.identifier = kNotificationActionIdentifileClose;
    action.title = @"Close";
    
    //当点击的时候不启动程序，在后台处理
    action.activationMode = UIUserNotificationActivationModeBackground;
    
    //需要解锁才能处理(意思就是如果在锁屏界面收到通知，并且用户设置了屏幕锁，用户点击了赞不会直接进入我们的回调进行处理，而是需要用户输入屏幕锁密码之后才进入我们的回调)，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action.authenticationRequired = NO;
    
    
    /*
     destructive属性设置后，在通知栏或锁屏界面左划，按钮颜色会变为红色
     如果两个按钮均设置为YES，则均为红色（略难看）
     如果两个按钮均设置为NO，即默认值，则第一个为蓝色，第二个为浅灰色
     如果一个YES一个NO，则都显示对应的颜色，即红蓝双色 (CP色)。
     */
    action.destructive = NO;
    
    
    //按钮2
    
    UIMutableUserNotificationAction *actionTwo = [[UIMutableUserNotificationAction alloc]init];
    
    actionTwo.identifier = kNotificationActionIdentifileBack;
    
    actionTwo.title = @"back2";
    
    actionTwo.activationMode = UIUserNotificationActivationModeBackground;//后台模式
    
    actionTwo.authenticationRequired = YES;
    
    actionTwo.destructive = NO;
    
    //创建动作(按钮)的类别集合
    
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc]init];
    
    category.identifier = kNotificationCategoryIdentifile;
    
    //最多支持两个，如果添加更多的话，后面的将被忽略
    [category setActions:@[action,actionTwo] forContext:UIUserNotificationActionContextMinimal];
    
    //创建UIUserNotificationSettings，并设置消息的显示类类型
    UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObject:category]];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    
}

// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"%@", notification.userInfo);
    [self showAlertView:@"计时完成~"];
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge -= notification.applicationIconBadgeNumber;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}



//在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler
{
    if ([identifier isEqualToString:kNotificationActionIdentifileClose]) {
        
        //关闭计时器
        [_timer.Player stop];
        
        
    }else if ([identifier isEqualToString:kNotificationActionIdentifileBack]){
        
        //回应用程序
        
    }
    
    completionHandler();
}







//通知按钮
- (void)showAlertView:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self.window.rootViewController showDetailViewController:alert sender:nil];
}










- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //让音频后台可播放
    
     [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
