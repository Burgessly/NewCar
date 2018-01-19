//
//  MutLocalData.m
//  ZhangChuDemo
//
//  Created by 黄嘉宏 on 15/9/22.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "MutLocalData.h"

@implementation MutLocalData
+(NSArray *)GetLocalDataArrayWithMainTableName:(NSString *)tableName tableArray:(NSArray *)tableArray childTableName:(NSString *)childTableName childTableArray:(NSArray *)childTableArray arrayKey:(NSString *)arrayKey{
    //把新数据存储到本地数据库中
    //********************************************************
    MyFMdataBase *myDB = [[MyFMdataBase alloc]init];
    
    [myDB createFMDataBaseWithFilePath:dataBaseFilePath];
    
    //创建数据库的list表单
    [myDB createTableWithTableName:tableName andTableArray:tableArray];
    
    //创建list表单中分类的表单
    [myDB createTableWithTableName:childTableName andTableArray:childTableArray];
    
    //查询表单中的数据
    NSArray *listArray = [myDB selectTableWithTableName:tableName andTableArray:tableArray];
    
    NSArray *valueListArray = [myDB selectTableWithTableName:childTableName andTableArray:childTableArray];
    
    //打印获取回来的数据
    NSLog(@"listArray = %@",listArray);
    
    NSLog(@"valueListArray = %@",valueListArray);
    
    NSMutableArray *listDataArray = [NSMutableArray array];
    
    //把获取回来的数据还原到和网络获取回来的数据一样
    //数据反操作
    for (NSDictionary *dic in listArray) {
        NSMutableDictionary *mdict = [[NSMutableDictionary alloc]initWithDictionary:dic];
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dict in valueListArray) {
            if ([dic[arrayKey] isEqualToString:dict[arrayKey]]) {
                
                NSMutableDictionary *mdic = [[NSMutableDictionary alloc]initWithDictionary:dict];
                
                [mdic removeObjectForKey:arrayKey];
                
                [mArr addObject:mdic];
            }
        }
        [mdict removeObjectForKey:arrayKey];
        
        [mdict setObject:mArr forKey:arrayKey];
        
        [listDataArray addObject:mdict];
    }
    
    [myDB closeDataBase];
    
    return listDataArray;
}

+(void)setLocalDataWithArray:(NSArray *)array tableName:(NSString *)tableName tableArray:(NSArray *)tableArray childTableName:(NSString *)childTableName childTableArray:(NSArray *)childTableArray arrayKey:(NSString *)arrayKey{
    //把新数据存储到本地数据库中
    //********************************************************
    MyFMdataBase *myDB = [[MyFMdataBase alloc]init];
    
    [myDB createFMDataBaseWithFilePath:dataBaseFilePath];
    
    //创建数据库的list表单
    [myDB createTableWithTableName:tableName andTableArray:tableArray];
    
    //创建list表单中分类的表单
    [myDB createTableWithTableName:childTableName andTableArray:childTableArray];
    
    //再插入之前，先把表单数据清空
    [myDB deleteTableWithTableName:tableName];
    
    [myDB deleteTableWithTableName:childTableName];
    
    //把每一条数据插入到表单中
    int i = 0;
    for (NSDictionary *dict in array) {
        
        NSMutableDictionary *mdict = [[NSMutableDictionary alloc]initWithDictionary:dict];
        
        //把数据取出来，然后键新的表单
        NSArray *vegetableListArray = [[NSArray alloc]initWithArray:mdict[arrayKey]];
        
        for (NSDictionary *vegetableDic in vegetableListArray) {
            NSMutableDictionary *mvDic = [[NSMutableDictionary alloc]init];
            
            //重新制作分类表单的结构dic（原来的网络表单有很多没有用到的数据）
            
            for (NSString *key in childTableArray) {
                if (vegetableDic[key]) {
                    [mvDic setObject:vegetableDic[key] forKey:key];
                }
            }
            [mvDic setObject:[NSString stringWithFormat:@"%d",i] forKey:arrayKey];
            
            [myDB insertDataIntoTableWithTableName:childTableName andTableDictionary:mvDic];
            
            NSLog(@"(*****************)");
        }
        //***********************************************
        
        [mdict removeObjectForKey:arrayKey];
        
        [mdict setObject:[NSString stringWithFormat:@"%d",i] forKey:arrayKey];
        
        [myDB insertDataIntoTableWithTableName:tableName andTableDictionary:mdict];
        
        i++;
    }
    
    [myDB closeDataBase];
    //********************************************************

}
@end
