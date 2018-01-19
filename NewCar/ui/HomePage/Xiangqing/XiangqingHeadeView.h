//
//  XiangqingHeadeView.h
//  NiucheProduct
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiangqingModel.h"

@protocol XiangqingHeadeViewDelegate <NSObject>

-(void)phoneToPeople;

@end

@interface XiangqingHeadeView : UIView

@property (nonatomic,weak) id<XiangqingHeadeViewDelegate> delegate;

-(void)setHeadeViewWithModel:(XiangqingModel *)model;

-(CGFloat)getViewHight;
@end
