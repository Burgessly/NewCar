//
//  NewFeatureCell.h
//  NewCar
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;

// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end
