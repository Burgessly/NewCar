//
//  GetData.m
//  NewCar
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GetData.h"

@implementation GetData

+(void)getDataFormUrl:(NSString *)urlString andResponsedSuccesss:(responseBlock)successHandler
{
    
    
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        successHandler(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}

@end
