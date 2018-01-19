//
//  JishiCell1.m
//  NewCar
//
//  Created by qianfeng on 16/1/6.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "JishiCell1.h"

@implementation JishiCell1

-(void)setCellWithModel:(JishiModel *)model
{
    self.titleLabel.text=model.content;
    self.nameLabell.text=[model.user objectForKey:@"name"];
    self.headImageView.layer.cornerRadius=10.0;
    self.headImageView.clipsToBounds=YES;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[model.user objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
}











- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
