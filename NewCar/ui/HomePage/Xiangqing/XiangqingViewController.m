//
//  XiangqingViewController.m
//  NiucheProduct
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XiangqingViewController.h"
#import "AFNetworking.h"
#import "XiangqingModel.h"
#import "JHRefresh.h"
#import "XiangqingHeadeView.h"
#import "XiangqingCellModel.h"
#import "XiangqingCell.h"
#import "PhotoVC.h"
#import "UMSocial.h"
@interface XiangqingViewController ()<UITableViewDataSource,UITableViewDelegate,XiangqingCellDelegate,XiangqingHeadeViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong) XiangqingModel * xiangqingModel;

@property (nonatomic,strong) NSString * phoneNum;
@end

@implementation XiangqingViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.tabBarController.tabBar.hidden=YES;
    
    self.navigationController.navigationBar.hidden=YES;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIActivityIndicatorView * indicator=[[UIActivityIndicatorView alloc]init];
    indicator.center=self.view.center;
    indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    [self getData];

    //[self performSelector:@selector(setButton) withObject:nil afterDelay:2];


}


-(void)getData
{
    self.dataArray=[[NSMutableArray alloc]init];

    __weak XiangqingViewController *weadSelf = self;
    
    [GetData getDataFormUrl:[NSString stringWithFormat:@"http://app.api.niuche.com/modi/case/detail?case_id=%ld",(long)self.id1] andResponsedSuccesss:^(id responseObj) {
        
       // NSDictionary * obj=[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        
        self.phoneNum=responseObj[@"data"][@"nr"][@"phone400"];
        weadSelf.xiangqingModel=[[XiangqingModel alloc]init];
        
        [weadSelf.xiangqingModel setValuesForKeysWithDictionary:responseObj];
        
        
        NSArray * array=responseObj[@"data"][@"pic_list"];
        
        for(NSDictionary * dict in array)
        {
            XiangqingCellModel * model=[[XiangqingCellModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:model];
        }
        if(self.dataArray.count>0)
        {
            [self setMyTableView];
            [self setButton];
        }
        
        [weadSelf.myTableView reloadData];
      
    }];
    
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;


}

-(void)setMyTableView
{
    self.myTableView = [[UITableView alloc]init];
    
    self.myTableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
    
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    XiangqingHeadeView * headeView=[[XiangqingHeadeView alloc]init];
  
    headeView.delegate=self;
    
    [headeView setHeadeViewWithModel:self.xiangqingModel];
    
    CGFloat headeView_High=[headeView getViewHight];
    
    headeView.frame=CGRectMake(0, 0, 320, headeView_High+5);
    
    self.myTableView.tableHeaderView=headeView;
    


}

-(void)setButton
{
    UIButton * backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    backButton.backgroundColor=[UIColor clearColor];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"navigation_back_button_image_normal.png"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToShouye) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];

    //分享按钮
    UIButton * shareButton=[[UIButton alloc]initWithFrame:CGRectMake(screenWidth-50, 5, 50, 40)];
    
    shareButton.backgroundColor=[UIColor clearColor];
    
    [shareButton setBackgroundImage:[UIImage imageNamed:@"common_share_button_normal.png"] forState:UIControlStateNormal];
    
    [shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shareButton];

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count-1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"CJ";

    XiangqingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XiangqingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.delegate=self;
    
    [cell setCellWithModel:self.dataArray[indexPath.row+1] andRowNum:indexPath.row];
    //[cell setCellWithModel:self.dataArray[indexPath.row]];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XiangqingCellModel * cellModel=self.dataArray[indexPath.row+1];
    
    NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect frame_H = [cellModel.description1 boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    
    return frame_H.size.height+220.0+10;
}



#pragma mark-按钮的点击事件
-(void)backToShouye
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)share
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"507fcab25270157b37000010" shareText:[[[self.xiangqingModel.data objectForKey:@"share"] objectForKey:@"weibo"] objectForKey:@"content"] shareImage:nil shareToSnsNames:@[UMShareToSina] delegate:nil];
}
#pragma mark-图片tiaozhuan
-(void)turnToPhontVC:(NSInteger)tag
{
    PhotoVC * photoVC=[[PhotoVC alloc]init];
    
    photoVC.dataArray=self.dataArray;
    
    photoVC.index=tag;
    
    [self presentViewController:photoVC animated:YES completion:nil];
    //[self.navigationController pushViewController:photoVC animated:YES];
    

}


-(void)phoneToPeople
{
    UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"操作提示：" message:[NSString stringWithFormat:@"你正在联系改装牛人%@：%@",[[self.xiangqingModel.data objectForKey:@"nr"]objectForKey:@"name"],self.phoneNum] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSLog(@"点解确认");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006019986"]];
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
