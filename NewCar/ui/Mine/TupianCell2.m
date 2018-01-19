//
//  TupianCell2.m
//  NewCar
//
//  Created by qianfeng on 16/1/5.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "TupianCell2.h"

@implementation TupianCell2

-(void)setCellWithModel:(TupianModel *)model
{
    NSArray * picArray=[[model picCover] componentsSeparatedByString:@";"];
    [self.OneImageView sd_setImageWithURL:[NSURL URLWithString:picArray[0]] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
    
    [self.TwoImageView sd_setImageWithURL:[NSURL URLWithString:picArray[1]] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
    
    [self.ThreeImageView sd_setImageWithURL:[NSURL URLWithString:picArray[2]] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
    
    self.titleLabel.text=model.title;
    self.srcLabel.text=model.src;
    self.publicTimeLabel.text=model.publishTime;

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
