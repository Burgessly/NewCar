//
//  XiangqingCell.h
//  NiucheProduct
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiangqingCellModel.h"

@protocol XiangqingCellDelegate <NSObject>

-(void)turnToPhontVC:(NSInteger)tag;

@end


@interface XiangqingCell : UITableViewCell

@property (nonatomic,weak) id<XiangqingCellDelegate> delegate;

-(void)setCellWithModel:(XiangqingCellModel *)model andRowNum:(NSInteger) rowNum;


@end
