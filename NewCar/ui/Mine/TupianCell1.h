//
//  TupianCell1.h
//  NewCar
//
//  Created by qianfeng on 16/1/5.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TupianModel.h"
@interface TupianCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UILabel *srcLabel;

@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;

-(void)setCellWithModel:(TupianModel *)model;




@end
