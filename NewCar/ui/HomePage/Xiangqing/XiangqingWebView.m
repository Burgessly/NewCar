//
//  XiangqingWebView.m
//  NiucheProduct
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XiangqingWebView.h"
//#import "DurexKit.h"
@interface XiangqingWebView ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView * webView;
@end

@implementation XiangqingWebView

- (void)viewDidLoad {
    
    self.title=@"改装视频";
    
    [super viewDidLoad];
    
    [self setBarButton];
    
    [self setMainWebView];
    //[NSThread detachNewThreadSelector:@selector(webViewLoadData) toTarget:self withObject:nil];
    
    //[self performSelector:@selector(webViewLoadData) withObject:nil afterDelay:2];
    // Do any additional setup after loading the view.
}

-(void)setMainWebView
{
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-64)];
    
    self.webView.backgroundColor=[UIColor whiteColor];
    
    self.webView.delegate=self;
    
    [self.view addSubview:self.webView];
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.niuche.com/nzhuanti/huodong/modi_video?t=%ld&id=%ld",(long)self.type,(long)self.id1]];
    
    NSLog(@"%@",url);
    
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
    
    [self.webView loadRequest:request];
   
}

-(void)webViewLoadData
{
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.niuche.com/nzhuanti/huodong/modi_video?t=%ld&id=%ld",(long)self.type,(long)self.id1]];
    
    NSLog(@"%@",url);
    
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
    
    [self.webView loadRequest:request];
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

-(void)rightButtonClick
{
   
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
