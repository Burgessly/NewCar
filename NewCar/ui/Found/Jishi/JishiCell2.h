//
//  JishiCell2.h
//  NewCar
//
//  Created by qianfeng on 16/1/6.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JishiModel.h"
@interface JishiCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headeImageView;

-(void)setCellWithModel:(JishiModel *)model;



@end
