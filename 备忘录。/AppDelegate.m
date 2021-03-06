//
//  AppDelegate.m
//  备忘录。
//
//  Created by apple on 15/4/30.
//  Copyright (c) 2015年 Lin. All rights reserved.
//

#import "AppDelegate.h"
#import "rootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate//应用委托程序，它是每一个ios应用都必须具备的启动入口，负责管理UIWindow对象
//UIWindow表示对象的唯一主窗口，为了可以让tableview,navigation显示在屏幕上，需要将它设置为UIWindow对象的根视图

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //根视图控制器
    rootViewController *rootViewCtrl = [[rootViewController alloc]
                                        initWithStyle:UITableViewStylePlain];
    UINavigationController *navCtrl = [[UINavigationController alloc]
                                       initWithRootViewController:rootViewCtrl];
    
    self.window.rootViewController = navCtrl;//将UINavigationController的表示图加入窗口层次结构
    [self.window makeKeyAndVisible];
    return YES;
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
