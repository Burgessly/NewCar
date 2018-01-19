//
//  JishiDetailCell1.h
//  NewCar
//
//  Created by qianfeng on 16/1/6.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JishiDetailModel.h"
@interface JishiDetailCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

-(void)setCellWithModel:(JishiDetailModel *)model;




@end
