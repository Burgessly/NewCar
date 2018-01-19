//
//  NewFeatureCell.m
//  NewCar
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "NewFeatureCell.h"
#import "CJTabBarController.h"
@interface NewFeatureCell ()

@property (nonatomic,weak) UIImageView * imageView;
@property (nonatomic,weak) UIButton * startButton;


@end
@implementation NewFeatureCell


- (UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [startBtn setTitle:@"开始改装之旅>>>" forState:UIControlStateNormal];
        [startBtn sizeToFit];
        [startBtn setTintColor:[UIColor whiteColor]];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
        
    }
    return _startButton;
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame=self.bounds;
    
    self.startButton.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.95 );
    
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        
        // 注意:一定要加载contentView
        [self.contentView addSubview:imageV];
        
    }
    return _imageView;
}




- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}



// 判断当前cell是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1) { // 最后一页,显示分享和开始按钮

        self.startButton.hidden = NO;
        
        
    }else{ // 非最后一页，隐藏分享和开始按钮

        self.startButton.hidden = YES;
    }
}

-(void)start
{
    CJTabBarController * tabbarVC=[[CJTabBarController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController=tabbarVC;
}







@end
