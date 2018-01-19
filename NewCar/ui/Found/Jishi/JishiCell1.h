//
//  JishiCell1.h
//  NewCar
//
//  Created by qianfeng on 16/1/6.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JishiModel.h"
@interface JishiCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabell;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


-(void)setCellWithModel:(JishiModel *)model;

@end
