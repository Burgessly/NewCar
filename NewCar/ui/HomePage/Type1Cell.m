//
//  Type1Cell.m
//  NiucheProduct
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Type1Cell.h"
#import "UIImageView+WebCache.h"
@interface Type1Cell ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *gaizhuangLabel;

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@property (weak, nonatomic) IBOutlet UILabel *collectLabel;

@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bootomImageView;

@end

@implementation Type1Cell

-(void)setCellWithModel:(Type1Model *)model
{
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.modi_case[@"cover"]] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];

    self.mainTitleLabel.text=model.modi_case[@"title"];
    
    self.nameLabel.text=model.modi_case[@"modi_car_name"];
    
    self.gaizhuangLabel.text=model.modi_case[@"modi_class_name"];
    
    self.placeLabel.text=model.modi_case[@"city_name"];

    self.collectLabel.text=[NSString stringWithFormat:@"%@",model.modi_case[@"favor_num"]];
    
    self.shareLabel.text=[NSString stringWithFormat:@"%@",model.modi_case[@"share_num"]];





}











- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
