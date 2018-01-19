//
//  XiangqingCell.m
//  NiucheProduct
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XiangqingCell.h"
#import "UIImageView+WebCache.h"
@interface XiangqingCell ()

@property (nonatomic,strong) UIImageView * mainImageView;

@property (nonatomic,strong) UILabel * mainLabel;

@end



@implementation XiangqingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    //创建大图
    self.mainImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
    
    self.mainImageView.backgroundColor=[UIColor clearColor];
    
    self.mainImageView.image=[UIImage imageNamed:@"define_loading_image_240.png"];
    
    [self addSubview:self.mainImageView];
    
    //创键label
    self.mainLabel=[[UILabel alloc]init];
    
    self.mainLabel.backgroundColor=[UIColor clearColor];
    
    self.mainLabel.numberOfLines=0;
    
    self.mainLabel.font=[UIFont systemFontOfSize:14];
    
    [self addSubview:self.mainLabel];
}

-(void)setCellWithModel:(XiangqingCellModel *)model andRowNum:(NSInteger) rowNum
{
    
    self.mainImageView.userInteractionEnabled=YES;

    self.mainImageView.tag=100+rowNum;
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];

    
    [self.mainImageView addGestureRecognizer:tap];

    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.link] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
    
    //contentLabel高度自适应
    self.mainLabel.frame=CGRectMake(10, 220, [UIScreen mainScreen].bounds.size.width-20, 10);

    NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect frame_H = [model.description1 boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    
    CGRect mainLabel_frame=self.mainLabel.frame;
    
    mainLabel_frame.size.height=frame_H.size.height+10;
    
    self.mainLabel.frame=mainLabel_frame;
    
    self.mainLabel.text=model.description1;

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
