//
//  MyFMdataBase.h
//  FMDataBaseFengZhuangSample
//
//  Created by 黄嘉宏 on 15/12/3.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

//需要使用该宏定义
// dataBaseFilePath [NSString stringWithFormat:@"%@/Documents/data.sqlite",NSHomeDirectory()]

@interface MyFMdataBase : NSObject

//1.创建数据库
-(void)createFMDataBaseWithFilePath:(NSString *)filePath;

//2.创建表单
-(void)createTableWithTableName:(NSString *)tableName andTableArray:(NSArray *)tableArray;

//3.插入数据
-(void)insertDataIntoTableWithTableName:(NSString *)tableName andTableDictionary:(NSDictionary *)dic;

//4.删除数据
-(void)deleteTableWithTableName:(NSString *)tableName andTableDictionary:(NSDictionary *)dic;

//4.2删除所有数据
-(void)deleteTableWithTableName:(NSString *)tableName;

//5.修改数据
-(void)updateTableWithTableName:(NSString *)tableName andUpDateTableDictionary:(NSDictionary *)dic andWhereTableDictionary:(NSDictionary *)whereDic;

//6.查询数据
-(NSArray *)selectTableWithTableName:(NSString *)tableName andTableArray:(NSArray *)tableArray;

//7.关闭数据库
-(void)closeDataBase;
@end
