//
//  ActivityWebView.m
//  NewCar
//
//  Created by qianfeng on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ActivityWebView.h"

@interface ActivityWebView ()<UIWebViewDelegate>

@end

@implementation ActivityWebView

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.tabBarController.tabBar.hidden=YES;
}





- (void)viewDidLoad {
    self.title=self.model.title;
    
    [super viewDidLoad];
    
    [self setBarButton];
    
    [self setMainWebView];
    // Do any additional setup after loading the view.
}


-(void)setMainWebView
{
    UIWebView * webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-64)];
    
    webView.backgroundColor=[UIColor whiteColor];
    
    webView.delegate=self;
    
    [self.view addSubview:webView];
    
    NSURL * url=[NSURL URLWithString:self.model.url];
    
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
    
    [webView loadRequest:request];
    
    
}

-(void)setBarButton
{
    
    //左按钮
    UIButton * leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [leftButton setBackgroundImage:[UIImage imageNamed:@"view_back_button_image_normal@2x.png"] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
