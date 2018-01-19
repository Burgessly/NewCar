//
//  Type3Cell.m
//  NiucheProduct
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Type3Cell.h"
#import "UIImageView+WebCache.h"
#import "MovicModel.h"
@interface Type3Cell ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;


@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;

@end

@implementation Type3Cell

-(void)setCellWithModel:(Type3Model *)model
{

    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.video[@"cover"]]];
    
    self.mainTitleLabel.text=model.video[@"title"];



}

-(void)setCellWithMovicModel:(MovicModel *)model
{
  [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
    
    self.mainTitleLabel.text=model.title;
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
