//
//  Type3Cell.h
//  NiucheProduct
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovicModel.h"
#import "Type3Model.h"
@interface Type3Cell : UITableViewCell

-(void)setCellWithModel:(Type3Model *)model;

-(void)setCellWithMovicModel:(MovicModel *)model;

@end
