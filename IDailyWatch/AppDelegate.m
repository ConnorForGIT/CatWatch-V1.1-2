//
//  AppDelegate.m
//  IDailyWatch
//
//  Created by 老师先给我发 on 14-10-13.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "AppDelegate.h"
#import "ToDayViewController.h"
#import "NewsViewController.h"
#import "BrandsViewController.h"
#import "VideosViewController.h"
#import "RESideMenu.h"
#import "LiftViewController.h"
#import "DataBaseManager.h"
#import <ShareSDK/ShareSDK.h>

#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

@implementation AppDelegate
- (void)startServer
{
    // Start the server (and check for problems)
    
    NSError *error;
    if([httpServer start:&error])
    {
    }
    else
    {
    }
    
}
- (void)setHttpServer
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];;// 如果需要，可以添加其他的日志输出支持

    httpServer = [[HTTPServer alloc] init];
    
    [httpServer setType:@"_http._tcp."];

    [httpServer setPort:12345];
    
    NSString *webPath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/TempVideo"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:webPath])
    {
        [fileManager createDirectoryAtPath:webPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [httpServer setDocumentRoot:webPath];
    NSLog(@"%@", webPath);
    [self startServer];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setHttpServer];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [ShareSDK registerApp:@"3ec5ee4bae8b"];     //参数为ShareSDK官网中添加应用后得到的AppKey
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    ToDayViewController * rvc = [[ToDayViewController alloc]init];
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:rvc];
    self.window.rootViewController = nav;
    [rvc release];
    [nav release];
    
    ToDayViewController * today = [[ToDayViewController alloc]init];
    today.tabBarController.tabBar.frame = CGRectMake(0, 0, 0, 0);
    today.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"每日推荐" image:[[UIImage imageNamed:@"todayW.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"todayO.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:                                                         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],UITextAttributeTextColor, nil]forState:UIControlStateSelected];
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    UINavigationController *nva1 = [[UINavigationController alloc]initWithRootViewController:today];
    
    
    
    NewsViewController * news = [[NewsViewController alloc]init];
    news.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"新闻资讯" image:[[UIImage imageNamed:@"newsO.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"newsW.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UINavigationController *nva2 = [[UINavigationController alloc]initWithRootViewController:news];
    
    
    BrandsViewController * brands = [[BrandsViewController alloc]init];
    brands.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"品牌百科" image:[[UIImage imageNamed:@"productW.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"productO.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *nva3 = [[UINavigationController alloc]initWithRootViewController:brands];
    
    
    VideosViewController * videos = [[VideosViewController alloc]init];
    videos.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"视频短片" image:[[UIImage imageNamed:@"videoW.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"videoO.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *nva4 = [[UINavigationController alloc]initWithRootViewController:videos];
    nva4.navigationBar.translucent = NO;
    
    UITabBarController * tab = [[UITabBarController alloc]init];
    tab.viewControllers = @[nva1,nva4,nva2,nva3];
    tab.tabBar.translucent = NO;
    
    LiftViewController *leftVC = [[LiftViewController alloc] init];
    RESideMenu *reside = [[RESideMenu alloc] initWithContentViewController:tab leftMenuViewController:leftVC rightMenuViewController:nil];
    
    
    
    [self.window setRootViewController:reside];
    
    [today release];
    [news release];
    [brands release];
    [videos release];
    
    [nva1 release];
    [nva2 release];
    [nva3 release];
    [nva4 release];
    
    
    [DataBaseManager create];
    
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
