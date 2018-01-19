//
//  DownLoadData.m
//  AiXianMianSample
//
//  Created by 黄嘉宏 on 15/12/7.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "DownLoadData.h"

#import "NetWorkState.h"

#import "MyFMdataBase.h"

#import "AFNetworking.h"

@interface DownLoadData ()

@property(nonatomic,strong)NSString *urlString;

@property(nonatomic,strong)NSString *tableName;

@property(nonatomic,strong)NSArray *tableArray;

@end


@implementation DownLoadData

//设置数据请求方法
-(void)setNetWorkDataUrlString:(NSString *)urlString andTableName:(NSString *)tableName tableArray:(NSArray *)tableArray{
    
    //给属性赋值
    self.urlString = urlString;
    
    self.tableName = tableName;
    
    self.tableArray = tableArray;

    //调用获取数据方法
    [self performSelector:@selector(getData) withObject:nil afterDelay:0.5];
}

#pragma mark 获取数据
-(void)getData{
    //获取判断网络单例
    NetWorkState *state = [NetWorkState shareNetWork];
    
    //获取当前网络状态
    BOOL isConnect = [state getNetWorkState];
    
    if (isConnect) {
        //发送请求
        [self getDataWithNetWork];
    }
    else{
        //读取数据库信息
        NSLog(@"读取数据库信息");
        
        [self getDataFromDataBase];
    }
}

#pragma mark 从数据库获取数据
- (void)getDataFromDataBase {
    //获取本地数据
    MyFMdataBase *myDataBase = [[MyFMdataBase alloc]init];
    
    [myDataBase createFMDataBaseWithFilePath:dataBaseFilePath];
    
    [myDataBase createTableWithTableName:self.tableName andTableArray:self.tableArray];
    
    NSArray *array = [myDataBase selectTableWithTableName:self.tableName andTableArray:self.tableArray];
    
    //把数据存储的单引号转换回来
    NSArray *dealedArray = [self dealCharInArray:array changeType:YES];
    
    NSLog(@"dataBaseArray = %@",dealedArray);
    
    //2.数据返回
    self.myBlock(dealedArray);
    
}

#pragma mark 从网络获取数据
- (void)getDataWithNetWork {
    //通过AFNetworking发送网络请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //获取数据成功，把数据写入数据库
        id dataObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        //需要根据数据修改
        [self saveDataToDataBase:dataObject[@"data"]];
        
        //1.数据返回
        self.myBlock(dataObject[@"data"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //获取数据失败，从数据库读取数据
        [self getDataFromDataBase];
        
    }];
}

#pragma mark 存储数据库
-(void)saveDataToDataBase:(NSArray *)array{
    
    NSArray *DealedArray = [self dealCharInArray:array changeType:NO];
    
    NSLog(@"%@",DealedArray);
    
    //获取本地数据
    MyFMdataBase *myDataBase = [[MyFMdataBase alloc]init];
    
    [myDataBase createFMDataBaseWithFilePath:dataBaseFilePath];
    
    [myDataBase createTableWithTableName:self.tableName andTableArray:self.tableArray];
    
    //每次插入数据前删除数据所有数据
    [myDataBase deleteTableWithTableName:self.tableName];
    
    //遍历数组，把数据插入数据库
    for (NSDictionary *dic in DealedArray) {
        [myDataBase insertDataIntoTableWithTableName:self.tableName andTableDictionary:dic];
    }
}

#pragma mark 转化字符串（在数据sql中不能出现单引号）
//注意数据修改，都需要使用可变的数组，字典
-(NSArray *)dealCharInArray:(NSArray *)array changeType:(BOOL)type{
    
    //遍历数据组，把数组中所有字符串中的单引号换成#*#去掉，获取时换回来
    NSMutableArray *mArr = [NSMutableArray array];
    
    //遍历数组中的所有字典
    for (NSDictionary *dic in array) {
        
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        //遍历字典中的所有字符串
        for (NSString *key in mDic.allKeys) {
            
            id objc = mDic[key];
            //判断是否是字符串类型
            if ([objc isKindOfClass:[NSString class]]) {
                
                NSString *objc_change = @"";
                if (type == NO) {
                    objc_change = [objc stringByReplacingOccurrencesOfString:@"'" withString:@"#*#"];
                }
                else{
                    objc_change = [objc stringByReplacingOccurrencesOfString:@"#*#" withString:@"'"];
                }
                
                [mDic setObject:objc_change forKey:key];
            }
            
        }
        [mArr addObject:mDic];
    }
    
    //返回数据
    return mArr;
}

@end
