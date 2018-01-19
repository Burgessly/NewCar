//
//  ActivityCell.m
//  NewCar
//
//  Created by qianfeng on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headeImageView;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@property (weak, nonatomic) IBOutlet UILabel *gaizhuangLabel;


@end

@implementation ActivityCell

-(void)setCellWithModel:(ActivityModel *)model
{
    self.headeImageView.layer.cornerRadius=25;
    
    self.headeImageView.clipsToBounds=YES;

    
    [self.headeImageView sd_setImageWithURL:[NSURL URLWithString:model.designer[@"avatar"]]];

    self.mainLabel.text=model.title;
    
    self.gaizhuangLabel.text=model.designer[@"nickname"];

}













- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
