//
//  TupianCell2.h
//  NewCar
//
//  Created by qianfeng on 16/1/5.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TupianModel.h"
@interface TupianCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UIImageView *OneImageView;

@property (weak, nonatomic) IBOutlet UIImageView *TwoImageView;


@property (weak, nonatomic) IBOutlet UIImageView *ThreeImageView;


@property (weak, nonatomic) IBOutlet UILabel *srcLabel;


@property (weak, nonatomic) IBOutlet UILabel *publicTimeLabel;

-(void)setCellWithModel:(TupianModel *)model;



@end
