//
//  JishiCell2.m
//  NewCar
//
//  Created by qianfeng on 16/1/6.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "JishiCell2.h"

@implementation JishiCell2

-(void)setCellWithModel:(JishiModel *)model
{
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
    self.titleLabel.text=model.content;
    self.nameLabel.text=[model.user objectForKey:@"name"];
    self.headeImageView.layer.cornerRadius=10.0;
    self.headeImageView.clipsToBounds=YES;
    [self.headeImageView sd_setImageWithURL:[NSURL URLWithString:[model.user objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];



}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
