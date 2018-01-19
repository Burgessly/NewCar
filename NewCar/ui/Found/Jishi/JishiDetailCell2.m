//
//  JishiDetailCell2.m
//  NewCar
//
//  Created by qianfeng on 16/1/6.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "JishiDetailCell2.h"

@implementation JishiDetailCell2

-(void)setCellWithModel:(JishiDetailModel *)model
{
    UILabel * contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth-20, 10)];
    //contentLabel.backgroundColor=[UIColor yellowColor];
    contentLabel.numberOfLines=0;
    contentLabel.font=[UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:contentLabel];
    
    NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect frame_H = [model.content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    
    CGRect contentLabel_frame=contentLabel.frame;
    
    contentLabel_frame.size.height=frame_H.size.height+10;
    
    contentLabel.frame=contentLabel_frame;
    
    contentLabel.text=model.content;
    
    NSArray * imageURLArray=model.imgs;
//    int lineNum=(int)((imageURLArray.count-1)/3)+1;
    
    CGFloat  picWidth=(screenWidth-40)/3;
    
    for(int i=0;i<imageURLArray.count;i++)
    {
        UIImageView * picImageView=[[UIImageView alloc]init];
        picImageView.frame=CGRectMake(10+(10+picWidth)*(i%3), CGRectGetMaxY(contentLabel.frame)+(95+10)*(i/3), picWidth, 95);
        [picImageView sd_setImageWithURL:[NSURL URLWithString:imageURLArray[i]] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
        [self.contentView addSubview:picImageView];
    }


}



























- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
