//
//  TupianCell1.m
//  NewCar
//
//  Created by qianfeng on 16/1/5.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "TupianCell1.h"

@implementation TupianCell1


-(void)setCellWithModel:(TupianModel *)model
{
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.picCover] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];

    self.titleLabel.text=model.title;
    self.srcLabel.text=model.src;
    self.publishTimeLabel.text=model.publishTime;


}











- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
