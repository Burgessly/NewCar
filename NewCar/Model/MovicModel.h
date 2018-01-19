//
//  MovicModel.h
//  NewCar
//
//  Created by qianfeng on 15/12/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovicModel : NSObject
{
    NSInteger _id;
}


@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSDictionary * share;
@property (nonatomic,strong) NSString * cover;
@property (nonatomic,assign) NSInteger browse_num;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger id1;
@property (nonatomic,strong) NSString * wap;

@end
