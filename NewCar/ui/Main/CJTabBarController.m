//
//  CJTabBarController.m
//  NewCar
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "CJTabBarController.h"

@interface CJTabBarController ()

@end

@implementation CJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent=NO;
    [self setUpAllChildViewController];
    // Do any additional setup after loading the view.
}

-(void)setUpAllChildViewController
{
    NavRootViewController * shouyeVC=[self createTabBarItemWithClass:[ShouYeViewController class] andTitle:@"首页" andImageName:@"icon-index-tab-1@2x.png" selectedImage:@"icon-index-tab-1-h@2x.png"];
    
    NavRootViewController * foundVC=[self createTabBarItemWithClass:[FoundViewController class] andTitle:@"发现" andImageName:@"icon-index-tab-3@2x.png" selectedImage:@"icon-index-tab-3-h@3x.png"];
    
    NavRootViewController * mineVC=[self createTabBarItemWithClass:[MineViewController class] andTitle:@"图片" andImageName:@"icon-index-tab-4@2x.png" selectedImage:@"icon-index-tab-4-h@2x.png"];
    
    self.viewControllers=@[shouyeVC,foundVC,mineVC];
}

-(NavRootViewController *)createTabBarItemWithClass:(Class) class andTitle:(NSString *)title andImageName:(NSString *)imageName selectedImage:(NSString *)selImageName
{
    UIViewController * vc=(UIViewController *)[[class alloc]init];
    
    vc.tabBarItem.title=title;
    
    vc.tabBarItem.image=[UIImage imageNamed:imageName];
    
    vc.tabBarItem.selectedImage=[[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0] } forState:UIControlStateNormal];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0], NSForegroundColorAttributeName:[UIColor colorWithRed:0.612 green:0.737 blue:0.129 alpha:1.000] } forState:UIControlStateSelected];
    
    NavRootViewController * nvc=[[NavRootViewController alloc]initWithRootViewController:vc];
    
    return nvc;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
