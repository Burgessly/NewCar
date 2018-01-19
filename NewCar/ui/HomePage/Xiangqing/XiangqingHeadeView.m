//
//  XiangqingHeadeView.m
//  NiucheProduct
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XiangqingHeadeView.h"
#import "UIImageView+WebCache.h"
@interface XiangqingHeadeView ()

@property (nonatomic,strong) UIImageView * mainImageView;

@property (nonatomic,strong) UILabel * mainLabel;

@property (nonatomic,strong) UILabel * carNameLabel;

@property (nonatomic,strong) UILabel * contentLabel;

@property (nonatomic,strong) UIImageView * headeImageView;

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UIButton * phoneButton;

@end

@implementation XiangqingHeadeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self =[super initWithFrame:frame])
    {
        [self creareUI];
    }
    return self;
}

-(void)creareUI
{
    
    //创建大图
    self.mainImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
    
    self.mainImageView.backgroundColor=[UIColor clearColor];
    
    [self addSubview:self.mainImageView];
    
    //创建标题
    self.mainLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, 300, 30)];
    
    self.mainLabel.numberOfLines=0;
    
    self.mainLabel.backgroundColor=[UIColor clearColor];
    
    [self addSubview:self.mainLabel];
    
    //创建carName
    self.carNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 250, 300, 20)];
    
    self.carNameLabel.backgroundColor=[UIColor clearColor];
    
    [self addSubview:self.carNameLabel];
    
    //创建内容label
    self.contentLabel=[[UILabel alloc]init];
    
    self.contentLabel.backgroundColor=[UIColor clearColor];
    
    self.contentLabel.numberOfLines=0;
    
    self.contentLabel.font=[UIFont systemFontOfSize:14];
    
    [self addSubview:self.contentLabel];
    
    //创建headeimageView
    self.headeImageView=[[UIImageView alloc]init];
    
    self.headeImageView.backgroundColor=[UIColor blackColor];
    
    [self addSubview:self.headeImageView];
    
    //创建nameLabel
    self.nameLabel=[[UILabel alloc]init];
    
    self.nameLabel.backgroundColor=[UIColor clearColor];
    
    self.nameLabel.font=[UIFont systemFontOfSize:15];
    
    [self addSubview:self.nameLabel];
    
    //创建titleLabel
    self.titleLabel=[[UILabel alloc]init];
    
    self.titleLabel.backgroundColor=[UIColor clearColor];
    
    self.titleLabel.font=[UIFont systemFontOfSize:13];
    
    self.titleLabel.textColor=[UIColor grayColor];
    
    [self addSubview:self.titleLabel];
    
    //创建phoneImageView
    self.phoneButton=[[UIButton alloc]init];
    
    self.phoneButton.backgroundColor=[UIColor clearColor];
    
    [self.phoneButton addTarget:self action:@selector(phoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.phoneButton];
}

-(void)setHeadeViewWithModel:(XiangqingModel *)model
{
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.data[@"cover"]] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
    
    self.mainLabel.text=model.data[@"title"];
    
    self.carNameLabel.text=model.data[@"modi_car_model_name"];
    
    //contentLabel高度自适应
    self.contentLabel.frame=CGRectMake(10, 270, [UIScreen mainScreen].bounds.size.width-20, 10);
    
    NSDictionary * contentDic=[[model.data valueForKey:@"pic_list"] firstObject];
    
    NSString * contentStr=contentDic[@"description"];
    
    //NSLog(@"%@...............",contentStr);
    
    NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect frame_H = [contentStr boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    
    CGRect contentLabel_frame=self.contentLabel.frame;
    
    contentLabel_frame.size.height=frame_H.size.height;
    
    self.contentLabel.frame=contentLabel_frame;
    
    self.contentLabel.text=contentStr;
    
    //设置头像
    self.headeImageView.frame=CGRectMake(10, 270+frame_H.size.height+10, 40, 40);
    
    [self.headeImageView sd_setImageWithURL:[NSURL URLWithString:model.data[@"nr"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
    
    self.headeImageView.layer.cornerRadius=20;
    
    self.headeImageView.clipsToBounds=YES;
    
    //设置nameLabel
    self.nameLabel.frame=CGRectMake(55, 270+frame_H.size.height+10, 225, 20);
    
    self.nameLabel.text=model.data[@"nr"][@"name"];
    
    //设置titleLable
    self.titleLabel.frame=CGRectMake(55, 270+frame_H.size.height+10+20, 225, 20);
    
    self.titleLabel.text=model.data[@"nr"][@"title"];

    //设置phoneButton
    self.phoneButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-40, 270+frame_H.size.height+10, 40, 40);
    
    [self.phoneButton setBackgroundImage:[UIImage imageNamed:@"call_common_button_normal@2x.png"] forState:UIControlStateNormal];
    
}

-(CGFloat)getViewHight
{
    return CGRectGetMaxY(self.titleLabel.frame);
}

-(void)phoneButtonClick
{
    [self.delegate phoneToPeople];
}
































/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
