//
//  XiangqingType2VC.m
//  NewCar
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XiangqingType2VC.h"
#import "XiangqingType2Model.h"
#import "XiangqingType2PicCell.h"
#import "XiangqingType2TextCell.h"
#import "UMSocial.h"
@interface XiangqingType2VC ()<UITableViewDataSource,UITableViewDelegate,XiangqingType2PicCellDelegate>

@property(nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong) NSString * headTitle;

@property (nonatomic,strong) NSMutableArray * photoArray;

//图片标记
@property (nonatomic,assign) int index;

@property (nonatomic,strong) NSString * shareContent;

@end

@implementation XiangqingType2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"内容详情";
    
    self.view.backgroundColor=[UIColor grayColor];
    
    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
    
    [self setBarButton];
    
    [self getData];
    
    [self setMyTableView];
    
    //[self setMyTableView];
    //[self performSelector:@selector(setHeadView) withObject:nil afterDelay:0.5];
    
    // Do any additional setup after loading the view.
}
#pragma mark-获取数据
-(void)getData
{
    self.index=0;
    
    self.dataArray=[[NSMutableArray alloc]init];
    
    self.photoArray=[[NSMutableArray alloc]init];
   
    __weak XiangqingType2VC *weadSelf = self;
    
    [GetData getDataFormUrl:[NSString stringWithFormat:@"http://app.api.niuche.com/modi/article/detail?article_id=%ld",(long)self.id1] andResponsedSuccesss:^(id responseObj) {
        
        // NSDictionary * obj=[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        
        
        self.headTitle=responseObj[@"data"][@"title"];

        self.shareContent=responseObj[@"data"][@"share"][@"weibo"][@"content"];
        
        NSArray * array=responseObj[@"data"][@"p_list"];
        
        for(NSDictionary * dict in array)
        {
            XiangqingType2Model * model=[[XiangqingType2Model alloc]init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:model];
        }
        
        if(self.dataArray.count>0)
        {
            [self setMyTableView];
        }
        
        
        //获取图片数组
        for(XiangqingType2Model * model in self.dataArray)
        {
            if(model.type==1)
            {
                [self.photoArray addObject:model.content];
            }
        }
        
        [weadSelf.myTableView reloadData];
        
        
    }];
    
    

    
    
    
}
    
#pragma mark-设置表格
-(void)setMyTableView
{
    self.myTableView = [[UITableView alloc]init];
    
    self.myTableView.frame = CGRectMake(0, 0, screenWidth, screenHeight-64);
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
    
    UILabel * headerView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 60)];
    headerView.numberOfLines=0;
    
    headerView.backgroundColor=[UIColor whiteColor];
    
    headerView.text=[NSString stringWithFormat:@"  %@",self.headTitle];
    
    self.myTableView.tableHeaderView=headerView;
    
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}




#pragma mark-表单协议

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if([[self.dataArray[indexPath.row] valueForKey:@"type"] integerValue]==0)
    {
        static NSString *ID = @"CJ";
        
        XiangqingType2TextCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[XiangqingType2TextCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell setCellWithModel:self.dataArray[indexPath.row]];
        
        return cell;
    }
    else if([[self.dataArray[indexPath.row] valueForKey:@"type"] integerValue]==1)
    {
        static NSString *ID = @"CJ1";

        XiangqingType2PicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"XiangqingType2PicCell" owner:self options:nil] firstObject];
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell setCellWithModel:self.dataArray[indexPath.row] andIndex:self.index];

        cell.delegate=self;
        
        self.index++;
        
        return cell;
    }
  
    return nil;


}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.dataArray[indexPath.row] valueForKey:@"type"] integerValue]==0)
    {
        XiangqingType2Model * model=self.dataArray[indexPath.row];
        
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGRect frame_H = [model.content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        return frame_H.size.height+10;
     
    }
    else if ([[self.dataArray[indexPath.row] valueForKey:@"type"] integerValue]==1)
    {
        return 220;
    }
    return 0;

}

#pragma mark-设置导航栏按钮
-(void)setBarButton
{
    
    //左按钮
    UIButton * leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [leftButton setBackgroundImage:[UIImage imageNamed:@"view_back_button_image_normal@2x.png"] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    //右按钮
    UIButton * rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"web_share_button_image_normal@2x.png"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    
}

#pragma mark-按钮点击
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick
{
    NSLog(@"分享");
    NSLog(@"%@",self.shareContent);
     [UMSocialSnsService presentSnsIconSheetView:self appKey:@"507fcab25270157b37000010" shareText:self.shareContent shareImage:nil shareToSnsNames:@[UMShareToSina] delegate:nil];
}

-(void)turnToPhontVC:(NSInteger)tag
{
    NSLog(@"图片点击%ld",(long)tag);
 
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
