//
//  Type2Cell.h
//  NiucheProduct
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Type2Model.h"
#import "NiurenSayModel.h"
@interface Type2Cell : UITableViewCell


-(void)setCellWithModel:(Type2Model *)model;

-(void)setCellWithNiurenSayModel:(NiurenSayModel *)model;
@end
