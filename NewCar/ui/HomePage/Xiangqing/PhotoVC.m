//
//  PhotoVC.m
//  NewCar
//
//  Created by qianfeng on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PhotoVC.h"
#import "XiangqingCellModel.h"
@interface PhotoVC ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * photoScrollView;
@property (nonatomic,strong) NSMutableArray * photoImageViewArray;
@property (nonatomic,strong) XiangqingCellModel * model;
@end

@implementation PhotoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoImageViewArray =[[NSMutableArray alloc]init];
    
    self.view.backgroundColor=[UIColor blackColor];
    
    NSLog(@"%lu",(unsigned long)self.dataArray.count);
    
    [self setPhotoScrollView];
    
    [self setButton];
    // Do any additional setup after loading the view.
}

-(void)setPhotoScrollView
{
    self.photoScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    [self.view addSubview:self.photoScrollView];
    
    self.photoScrollView.contentSize=CGSizeMake(screenWidth*(self.dataArray.count-1), screenHeight);

    self.photoScrollView.bounces=YES;
    
    self.photoScrollView.showsHorizontalScrollIndicator=NO;
    
    self.photoScrollView.pagingEnabled=YES;
    
    [self.photoScrollView setContentOffset:CGPointMake(screenWidth*(self.index%100), 0)];
    
    for(int i=0;i<self.dataArray.count-1;i++)
    {
        UIImageView * photoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*screenWidth, 0, screenWidth, screenHeight)];
        
        self.model=self.dataArray[i+1];
        
        photoImageView.contentMode=UIViewContentModeScaleAspectFit;

        [photoImageView sd_setImageWithURL:[NSURL URLWithString:self.model.link] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];
        
        [self.photoImageViewArray addObject:photoImageView];
        
        [self.photoScrollView addSubview:photoImageView];
    }


}

-(void)setButton
{
    UIButton * backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    backButton.backgroundColor=[UIColor clearColor];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"navigation_back_button_image_normal.png"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backBUttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    
    //分享按钮
    UIButton * downloadButton=[[UIButton alloc]initWithFrame:CGRectMake(screenWidth-50, 5, 50, 40)];
    
    downloadButton.backgroundColor=[UIColor clearColor];
    
    [downloadButton setBackgroundImage:[UIImage imageNamed:@"common_dowload_button_nromal@2x.png"] forState:UIControlStateNormal];
    
    [downloadButton addTarget:self action:@selector(downloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:downloadButton];
    
}

-(void)backBUttonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)downloadButtonClick:(UIImage *)image
{
    UIImageView * imageView= self.photoImageViewArray[(int)(self.photoScrollView.contentOffset.x/screenWidth)];

    UIImageWriteToSavedPhotosAlbum(imageView.image,self,@selector(image:didFinishSavingWithError:contextInfo:), nil);

}


-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if(error != NULL)
    {
        NSLog(@"%@",error);
    }
    else{
    UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"图片保存成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertView show];

    }
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
