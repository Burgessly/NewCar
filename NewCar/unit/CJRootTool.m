//
//  CJRootTool.m
//  NewCar
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "CJRootTool.h"
#import "CJTabBarController.h"
#import "NewFeatureController.h"
#define CJVersionKey @"version"


@implementation CJRootTool
// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window
{
    // 1.获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:CJVersionKey];
    
    // v1.0
    // 判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion]) { // 没有最新的版本号
        
        // 创建tabBarVc
        CJTabBarController *tabBarVc = [[CJTabBarController alloc] init];
        
        // 设置窗口的根控制器
        window.rootViewController = tabBarVc;
        
        
    }else{ // 有最新的版本号
        
        // 进入新特性界面
        // 如果有新特性，进入新特性界面
        NewFeatureController *vc = [[NewFeatureController alloc] init];
        
        window.rootViewController = vc;
        
        // 保持当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:CJVersionKey];
    }
}




@end
