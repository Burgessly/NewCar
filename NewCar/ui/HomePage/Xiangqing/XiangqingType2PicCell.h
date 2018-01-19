//
//  XiangqingType2PicCell.h
//  NewCar
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiangqingType2Model.h"

@protocol XiangqingType2PicCellDelegate <NSObject>

-(void)turnToPhontVC:(NSInteger)tag;

@end





@interface XiangqingType2PicCell : UITableViewCell

@property (nonatomic,weak) id<XiangqingType2PicCellDelegate> delegate;

-(void)setCellWithModel:(XiangqingType2Model *)model andIndex:(int)index;



@end
