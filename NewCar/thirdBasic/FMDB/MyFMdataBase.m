//
//  MyFMdataBase.m
//  FMDataBaseFengZhuangSample
//
//  Created by 黄嘉宏 on 15/12/3.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "MyFMdataBase.h"

#import "FMDatabase.h"

@interface MyFMdataBase ()

@property(nonatomic,strong)FMDatabase *myDataBase;

@end

@implementation MyFMdataBase

-(void)createFMDataBaseWithFilePath:(NSString *)filePath{
    //数据库存放路径
//    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/data.rdb",NSHomeDirectory()];
    
    //打印数据库的存放路径
    NSLog(@"filePath = %@",filePath);
    
    //创建一个FMDB的对象
    self.myDataBase = [[FMDatabase alloc]initWithPath:filePath];
    
    //调用.open属性，会打开对应文件路径的数据库
    //1.已经有数据库，直接打开
    //2.如果没有数据库，先在该路径上创建一个数据库，并且打开
    //3.返回的BOOL告诉程序员，数据库是否打开成功
    if (self.myDataBase.open) {
        NSLog(@"数据库打开成功");
    }
    else{
        NSLog(@"数据库打开失败");
    }
}

#pragma mark 创建表单
-(void)createTableWithTableName:(NSString *)tableName andTableArray:(NSArray *)tableArray{
    
    //创建表单语法:CREATE TABLE IF NOT EXISTS
    //1.如果有该表单，直接打开
    //2.如果没有该表单，创建一个再打开
    //studentInfo:表单名称（自己取，在同一个数据库中，表单名称不能重名）
    //括号中表示表单的结构（字段名设置）
//    NSString *sql = @"CREATE TABLE IF NOT EXISTS studentInfo(name varchar(32),age INTEGER,score INTEGER)";
    
    //制作一个可变字符串，完成字符串拼接
    NSString *tableArrayString = @"";
    for (NSString *nameStirng in tableArray) {
        tableArrayString = [NSString stringWithFormat:@"%@,%@ varchar(32)",tableArrayString,nameStirng];
    }
    
//    NSLog(@"tableArrayString = %@",tableArrayString);
    tableArrayString = [tableArrayString substringFromIndex:1];
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",tableName,tableArrayString];
    
    //把sql语句放入创建好的fmdataBase中，进行表创建
    //如果创建成果，返回boolYES，否则返回NO
    BOOL b = [self.myDataBase executeUpdate:sql];
    
    if (b) {
        NSLog(@"创建表单成功");
    }
    else{
        NSLog(@"创建表单失败");
    }
    
}

-(void)insertDataIntoTableWithTableName:(NSString *)tableName andTableDictionary:(NSDictionary *)dic{
    
    //1.INSERT INTO:在表单中插入数据的关键字
    //2.studentInfo:表单名（要与创建表单时的名称一致）
    //3.括号中填写的是表单结构（表单结构需要与创建时的表单结构一致）
    //4.VALUES:表单中所需要传入的值
    //5.括号中对应的是表单结构中所要插入的值代表符（有多少个字段名，就对应有多少个问号）
//    NSString *sql = @"INSERT INTO studentInfo(name,age,score) VALUES('hjh','15','100')";
    
    NSString *tableNameArrayString = @"";
    
    NSString *valueStirng = @"";
    
    for (NSString *key in dic.allKeys) {
        //拼写字段名的key值
        tableNameArrayString = [NSString stringWithFormat:@"%@,%@",tableNameArrayString,key];
        
        //拼写写入值的value值
        valueStirng = [NSString stringWithFormat:@"%@,'%@'",valueStirng,dic[key]];
    }
    
    //处理拼出来的字符串第一个逗号（删除掉）
    tableNameArrayString = [tableNameArrayString substringFromIndex:1];
    
    valueStirng = [valueStirng substringFromIndex:1];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES(%@)",tableName,tableNameArrayString,valueStirng];
    
    //使用sql插入语法把数据插入到表单中（有多少个问号，对应在sql语法后面就跟随多少个字符串参数）
    BOOL b = [self.myDataBase executeUpdate:sql];
    
    if (b) {
        NSLog(@"插入成功");
    }
    else{
        NSLog(@"插入成功");
    }
    
}

#pragma mark 删除数据
-(void)deleteTableWithTableName:(NSString *)tableName andTableDictionary:(NSDictionary *)dic{

    
    //DELETE FROM:删除表单数据的关键字
    //studentInfo:表单名，你需要删除的表单名称（与创建表单的名称要一致）
    //WHERE:筛选条件关键字
    //name:字段名
    //字段名 ＝ value 满足该条件的数据方可删除
//    NSString *sql = @"DELETE FROM studentInfo WHERE name = ?";
    
    NSString *deleteTableArrayString = @"";
    for (NSString *key in dic.allKeys) {
        deleteTableArrayString = [NSString stringWithFormat:@"%@ AND %@ = '%@'",deleteTableArrayString,key,dic[key]];
    }
    
    deleteTableArrayString = [deleteTableArrayString substringFromIndex:4];
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",tableName,deleteTableArrayString];
    
    BOOL b = [self.myDataBase executeUpdate:sql];
    
    if (b) {
        NSLog(@"删除数据成功");
    }
    else{
        NSLog(@"删除数据失败");
    }
}

#pragma mark 删除所有数据
-(void)deleteTableWithTableName:(NSString *)tableName{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
    
    BOOL b = [self.myDataBase executeUpdate:sql];
    
    if (b) {
        NSLog(@"删除数据成功");
    }
    else{
        NSLog(@"删除数据失败");
    }
}


#pragma mark 修改数据
-(void)updateTableWithTableName:(NSString *)tableName andUpDateTableDictionary:(NSDictionary *)dic andWhereTableDictionary:(NSDictionary *)whereDic{
    
    //UPDATE:更新某条数据的关键字
    //studentInfo:需要修改的表单
    //SET:修改字段的关键字
    //name:需要修改的字段名
    //name = ? 把某个字段的元素值修改为传进来的值
    //WHERE:修改name字段的条件
    //满足age = ? 等于对应的值的数据，才改变他的name元素内容
//    NSString *sql = @"UPDATE studentInfo SET name = ? WHERE age = ?";
    
//    NSString *name = @"hjj2015";
//    
//    int age = 10;
    
    //拼接设置的字段名字符串
    NSString *setTableNameString = @"";
    for (NSString *key in dic.allKeys) {
        
        setTableNameString = [NSString stringWithFormat:@"%@,%@ = '%@'",setTableNameString,key,dic[key]];
    }
    setTableNameString = [setTableNameString substringFromIndex:1];
    
    //条件设置字段名字符串
    NSString *whereTableNameStirng = @"";
    for (NSString *key in whereDic.allKeys) {
        
        whereTableNameStirng = [NSString stringWithFormat:@"%@ AND %@ = '%@'",whereTableNameStirng,key,whereDic[key]];
    }
    
    whereTableNameStirng = [whereTableNameStirng substringFromIndex:4];
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",tableName,setTableNameString,whereTableNameStirng];
    
    BOOL b = [self.myDataBase executeUpdate:sql];
    
    if (b) {
        NSLog(@"修改成功");
    }
    else{
        NSLog(@"修改失败");
    }
    
}

#pragma mark 查询数据库
-(NSArray *)selectTableWithTableName:(NSString *)tableName andTableArray:(NSArray *)tableArray{
    
//    NSString *sql = @"SELECT * FROM studentInfo";
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    
    //通过sql语法返回表单中的查找数据集合
    //executeQuery:获取数据的方法
    FMResultSet *result = [self.myDataBase executeQuery:sql];
    
    
    //创建数组装载查找出来的数据
    NSMutableArray *returnArray = [NSMutableArray array];
    
    //result的next方法
    //1.设定result指向的当前元素
    //2.根据这个元素的链尾，判断还有没有下一个元素
    //如果还有第二个元素，返回YES，如果没有，返回NO
    while ([result next]) {
        NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
        //把取出来的数据从新组装
        for (NSString *key in tableArray) {
            
            NSString *value = [result stringForColumn:key];
            
            [mdic setObject:value forKey:key];
        }
        
        [returnArray addObject:mdic];
    }
    
//    NSLog(@"array = %@",returnArray);
    
    return returnArray;
    
}

-(void)closeDataBase{
    [self.myDataBase close];
}
@end
