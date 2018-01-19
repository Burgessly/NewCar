//
//  Type2Cell.m
//  NiucheProduct
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Type2Cell.h"
#import "UIImageView+WebCache.h"

@interface Type2Cell ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *gaizhuangLabel;

@property (weak, nonatomic) IBOutlet UILabel *collectLabel;


@property (weak, nonatomic) IBOutlet UILabel *shareLabel;


@end

@implementation Type2Cell

-(void)setCellWithModel:(Type2Model *)model
{
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.article[@"cover"]]];

    self.mainTitleLabel.text=model.article[@"title"];
    
    self.gaizhuangLabel.text=model.article[@"modi_class_name"];
    
    self.collectLabel.text=[NSString stringWithFormat:@"%@",model.article[@"favor_num"]];
    
    self.shareLabel.text=[NSString stringWithFormat:@"%@",model.article[@"share_num"]];
}


-(void)setCellWithNiurenSayModel:(NiurenSayModel *)model
{
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];

    self.mainTitleLabel.text=model.title;
    
    self.gaizhuangLabel.text=model.modi_class_name;
    
    self.collectLabel.text=[NSString stringWithFormat:@"%ld",(long)model.favor_num];
    
    self.shareLabel.text=[NSString stringWithFormat:@"%ld",(long)model.share_num];

}














- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
