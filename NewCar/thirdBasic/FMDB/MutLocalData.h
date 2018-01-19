//
//  MutLocalData.h
//  ZhangChuDemo
//
//  Created by 黄嘉宏 on 15/9/22.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

//必须同时拥有FMDataBase和MyFMDataBase文件才能使用

#import <Foundation/Foundation.h>
#import "MyFMdataBase.h"
@interface MutLocalData : NSObject

//二级数据存储表单读取
//tableName主菜单表名
//tableArray主菜单表结构
//childTableName子表单表名
//childTableArray子表单表结构
//arrayKey表单关联主键（使用数组的key作为主键）
+(NSArray *)GetLocalDataArrayWithMainTableName:(NSString *)tableName tableArray:(NSArray *)tableArray childTableName:(NSString *)childTableName childTableArray:(NSArray *)childTableArray arrayKey:(NSString *)arrayKey;

//array为获取得到的双表单数组数据
+(void)setLocalDataWithArray:(NSArray *)array tableName:(NSString *)tableName tableArray:(NSArray *)tableArray childTableName:(NSString *)childTableName childTableArray:(NSArray *)childTableArray arrayKey:(NSString *)arrayKey;
@end
