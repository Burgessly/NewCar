//
//  AppDelegate.m
//  NewCar
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"

#import "UMSocial.h"
#import "UIImageView+WebCache.h"
#import "LaunchDemo.h"
#import "CJRootTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //友盟分享
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    
    //如果需要监听网络状态在程序开始时制作
    NetWorkState *state = [NetWorkState shareNetWork];
    
    //开启网络监听
    [state startNetWorkStateMonitor];
    
    [CJRootTool chooseRootViewController:self.window];
    
    self.window.backgroundColor=[UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    LaunchDemo *demo = [LaunchDemo new];
    demo.iconFrame = CGRectMake((screenWidth - 213) * 0.5, 80, 213, 54);
    demo.desLabelFreme = CGRectMake(0, screenHeight - 34, screenWidth, 25);
    [demo loadLaunchImage:@"Default@2x.png"
                 iconName:nil
              appearStyle:JRApperaStyleNone
                  bgImage:@"Default-568h@2x.png"
                disappear:JRDisApperaStyleOne
           descriptionStr:@""];
    demo.desLabel.font = [UIFont systemFontOfSize:12];
    demo.desLabel.textColor = [UIColor whiteColor];
    
    
    

    return YES;
}


-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
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
