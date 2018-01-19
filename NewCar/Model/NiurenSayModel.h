//
//  NiurenSayModel.h
//  NewCar
//
//  Created by qianfeng on 15/12/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NiurenSayModel : NSObject
{
    NSInteger _id;
}
@property (nonatomic,assign) NSInteger share_num;
@property (nonatomic,assign) NSInteger favor_num;
@property (nonatomic,strong) NSString * modi_class_name;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * car_series_name;
@property (nonatomic,strong) NSString * cover;
@property (nonatomic,strong) NSString * modi_car_name;

@property (nonatomic,assign) NSInteger modi_class_id;
@property (nonatomic,strong) NSDictionary * nr;
@property (nonatomic,assign) NSInteger modi_car_series_id;
@property (nonatomic,assign) NSInteger id1;



@end
