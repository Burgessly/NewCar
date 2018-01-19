//
//  DetailVC.m
//  NewCar
//
//  Created by qianfeng on 16/1/5.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "DetailVC.h"
#import "PhotoDetailModel.h"
@interface DetailVC ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UILabel * titleLable;
@property (nonatomic,strong) UITextView * contentTextView;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) UILabel * indexLabel;
@end

@implementation DetailVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    self.dataArray=[NSMutableArray array];
    [self setButton];
    
    [self getData];
    //[self createUI];
    //[self performSelector:@selector(createUI) withObject:self afterDelay:1];
    // Do any additional setup after loading the view.
}

-(void)setButton
{
    UIButton * backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    backButton.backgroundColor=[UIColor clearColor];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"navigation_back_button_image_normal.png"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backBUttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
}

-(void)backBUttonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getData
{
    NSLog(@"%@",self.detailId);
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://api.ycapp.yiche.com/appnews/GetNewsAlbum?newsid=%@",self.detailId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.title=responseObject[@"data"][@"title"];
        NSArray * array=responseObject[@"data"][@"albums"];
        for(NSDictionary * dict in array)
        {
            PhotoDetailModel * model=[[PhotoDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        if(self.dataArray.count>0)
        {
            [self createUI];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}

-(void)createUI
{
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, (screenHeight-50)*0.66)];
    //self.scrollView.backgroundColor=[UIColor yellowColor];
    self.scrollView.delegate=self;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize=CGSizeMake(screenWidth*(self.dataArray.count), (screenHeight-50)*0.66);
    
    self.scrollView.bounces=YES;
    
    self.scrollView.showsHorizontalScrollIndicator=YES;
    
    self.scrollView.pagingEnabled=YES;
    
    for(int i=0;i<self.dataArray.count;i++)
    {
        UIImageView * photoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*screenWidth, 0, screenWidth, (screenHeight-50)*0.66)];
        
        PhotoDetailModel * model=self.dataArray[i];
        
        photoImageView.contentMode=UIViewContentModeScaleAspectFit;
        
        [photoImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"define_loading_image_240@2x.png"]];

        
        [self.scrollView addSubview:photoImageView];
    }
    
    //设置label
    self.titleLable=[[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scrollView.frame), screenWidth-20, 20)];
    self.titleLable.textColor=[UIColor whiteColor];
    self.titleLable.font=[UIFont systemFontOfSize:14];
    self.titleLable.text=self.title;
    [self.view addSubview:self.titleLable];
    
    //设置textView；
    self.contentTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLable.frame), screenWidth-20, 70)];
    self.contentTextView.backgroundColor=[UIColor clearColor];
    self.contentTextView.textColor=[UIColor whiteColor];
    self.contentTextView.font=[UIFont systemFontOfSize:13];
    if(self.dataArray.count>0)
    {
    self.contentTextView.text=[self.dataArray[0] content];
    }
    self.contentTextView.editable=NO;
    [self.view addSubview:self.contentTextView];
    
    //设置indexLabel
    self.indexLabel=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth-15-40, CGRectGetMaxY(self.contentTextView.frame)+15, 40, 20)];
    self.indexLabel.textColor=[UIColor whiteColor];
    self.indexLabel.font=[UIFont systemFontOfSize:14];
    self.indexLabel.text=[NSString stringWithFormat:@"1/%lu",(unsigned long)self.dataArray.count];
    self.indexLabel.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:self.indexLabel];
}


#pragma mark-scrollView代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index=scrollView.contentOffset.x/screenWidth;
    self.contentTextView.text=[self.dataArray[index] content];
    self.indexLabel.text=[NSString stringWithFormat:@"%d/%lu",index+1,(unsigned long)self.dataArray.count];
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
