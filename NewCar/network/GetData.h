//
//  GetData.h
//  NewCar
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^responseBlock)(id responseObj);
@interface GetData : NSObject
+(void)getDataFormUrl:(NSString *)urlString andResponsedSuccesss:(responseBlock)successHandler;
@end
