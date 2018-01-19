//
//  NetWorkState.m
//  01-AixianMianSample
//
//  Created by 黄嘉宏 on 15/12/4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "NetWorkState.h"

#import "AFNetworking.h"

@interface NetWorkState ()

@property(nonatomic,assign)BOOL isConnect;

@end

@implementation NetWorkState
+(id)shareNetWork{
    static NetWorkState *netState = nil;
    
    if (netState == nil) {
        netState = [[super alloc]init];
    }
    
    return netState;
}

#pragma mark - 判断网络状态
-(void)startNetWorkStateMonitor{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"www.baidu.com"]];
    
    [manager.requestSerializer setValue:@"value" forHTTPHeaderField:@"key"];
    
    //调用reachability来判断网络是否可用
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            [NSThread mainThread];
            
            NSLog(@"目前网络不可用");
            
            self.isConnect = NO;
        }
        else if(status == AFNetworkReachabilityStatusReachableViaWWAN){
            
            [NSThread mainThread];
            
            NSLog(@"当前是移动（3G）网络");
            
            self.isConnect = YES;
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            
            [NSThread mainThread];
            
            NSLog(@"当前是wifi网络");
            
            self.isConnect = YES;
        }
    }];
    
    //必须要把这个监听打开
    [manager.reachabilityManager startMonitoring];
}

#pragma mark 返回当前网络状态
-(BOOL)getNetWorkState{
    return self.isConnect;
}

@end
