//
//  DownLoadData.h
//  AiXianMianSample
//
//  Created by 黄嘉宏 on 15/12/7.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

//声明block传参
typedef void(^dataReturnBlock)(id);

@interface DownLoadData : NSObject

//声明属性
@property(nonatomic,copy)dataReturnBlock myBlock;

//设置数据请求方法
-(void)setNetWorkDataUrlString:(NSString *)urlString andTableName:(NSString *)tableName tableArray:(NSArray *)tableArray;



/*
 //需要在appDelegate中注册网络状态监听
 
 //如果需要监听网络状态在程序开始时制作
 NetWorkState *state = [NetWorkState shareNetWork];
 
 //开启网络监听
 [state startNetWorkStateMonitor];
 */
@end
