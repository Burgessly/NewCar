//
//  XiangqingType2TextCell.m
//  NewCar
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XiangqingType2TextCell.h"

@interface XiangqingType2TextCell ()

@property (nonatomic,strong) UILabel * contentLabel;

@end


@implementation XiangqingType2TextCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        [self createUI];
    }
    
    return self;
}

-(void)createUI
{
    self.contentLabel=[[UILabel alloc]init];
    
    self.contentLabel.font=[UIFont systemFontOfSize:14];
    
    self.contentLabel.numberOfLines=0;
    
    [self addSubview:self.contentLabel];
}

-(void)setCellWithModel:(XiangqingType2Model *)model
{
    //contentLabel高度自适应
    self.contentLabel.frame=CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 10);
    
    NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect frame_H = [model.content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    
    CGRect contentLabel_frame=self.contentLabel.frame;
    
    contentLabel_frame.size.height=frame_H.size.height+10;
    
    self.contentLabel.frame=contentLabel_frame;
    
    self.contentLabel.text=model.content;


}
















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
