//
//  Type3Model.h
//  NiucheProduct
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Type3Model : NSObject
{
    NSString * _id;
}

@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSString * id1;
@property (nonatomic,strong) NSDictionary * video;

@end
