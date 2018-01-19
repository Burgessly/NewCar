//
//  FoundPageCell.m
//  NewCar
//
//  Created by qianfeng on 15/12/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FoundPageCell.h"

#define typeArray @[@"牛人说",@"牛车集市",@"改装视频",@"优惠活动"]

@interface FoundPageCell ()

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;


@end

@implementation FoundPageCell

-(void)setCellWithModel:(FoundModel *)model
{

    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];

    self.typeLabel.text=[typeArray objectAtIndex:(model.type-1)];

}













- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
