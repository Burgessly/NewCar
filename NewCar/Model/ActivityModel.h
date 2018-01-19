//
//  ActivityModel.h
//  NewCar
//
//  Created by qianfeng on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ActivityModel : NSObject
{
    NSInteger _id;
}




@property (nonatomic,strong) NSDictionary * designer;

@property (nonatomic,strong) NSString * title;

@property (nonatomic,strong) NSString * url;

@property (nonatomic,strong) NSString * create_time;

@property (nonatomic,assign) NSInteger designer_id;

@property (nonatomic,assign) BOOL need_login;

@property (nonatomic,assign) NSInteger id1;








@end
