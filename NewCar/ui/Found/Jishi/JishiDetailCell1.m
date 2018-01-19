//
//  JishiDetailCell1.m
//  NewCar
//
//  Created by qianfeng on 16/1/6.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "JishiDetailCell1.h"

@implementation JishiDetailCell1


-(void)setCellWithModel:(JishiDetailModel *)model
{
    self.headImageView.layer.cornerRadius=20.0;
    self.headImageView.clipsToBounds=YES;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[model.user objectForKey:@"avatar"]]];
    self.nameLabel.text=[model.user objectForKey:@"name"];
    
    //NSLog(@"%@",[model.user objectForKey:@"name"]);
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
