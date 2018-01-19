//
//  XiangqingType2PicCell.m
//  NewCar
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XiangqingType2PicCell.h"

@interface XiangqingType2PicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;


@end


@implementation XiangqingType2PicCell

-(void)setCellWithModel:(XiangqingType2Model *)model andIndex:(int)index
{
    self.picImageView.userInteractionEnabled=YES;
    
    self.picImageView.tag=100+index;
    
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
    
    [self.picImageView addGestureRecognizer:tap];
}

-(void)imageViewClick:(UITapGestureRecognizer *)tap
{
    [self.delegate turnToPhontVC:tap.view.tag];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
