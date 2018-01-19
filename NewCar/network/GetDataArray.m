//
//  GetDataArray.m
//  NewCar
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "GetDataArray.h"

@implementation GetDataArray

+(NSMutableArray *)getDataModelArrayWithArray:(NSArray *)array
{
    NSMutableArray * dataModelArray=[NSMutableArray array];
    
    for(NSDictionary * dict in array)
    {
        if([dict[@"type"]integerValue]==1)
        {
            Type1Model * model1=[[Type1Model alloc]init];
            
            [model1 setValuesForKeysWithDictionary:dict];
            
            [dataModelArray addObject:model1];
        }
        else if([dict[@"type"]integerValue]==2)
        {
            Type2Model * model1=[[Type2Model alloc]init];
            
            [model1 setValuesForKeysWithDictionary:dict];
            
            [dataModelArray addObject:model1];
        }
        else if([dict[@"type"]integerValue]==3)
        {
            Type3Model * model1=[[Type3Model alloc]init];
            
            [model1 setValuesForKeysWithDictionary:dict];
            
            [dataModelArray addObject:model1];
        }
        
    }
    
    return dataModelArray;
    
}



@end
