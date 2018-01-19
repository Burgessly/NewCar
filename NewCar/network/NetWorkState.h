//
//  NetWorkState.h
//  01-AixianMianSample
//
//  Created by 黄嘉宏 on 15/12/4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkState : NSObject

+(id)shareNetWork;

//该方法只需运行一次
-(void)startNetWorkStateMonitor;

-(BOOL)getNetWorkState;

@end
