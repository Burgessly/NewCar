//
//  JishiDetailVC.m
//  NewCar
//
//  Created by qianfeng on 16/1/6.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "JishiDetailVC.h"
#import "JishiDetailModel.h"
#import "JishiDetailCell1.h"
#import "JishiDetailCell2.h"
@interface JishiDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) JishiDetailModel * model;
@property (nonatomic,strong) UITableView * myTableView;
@end

@implementation JishiDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"内容详情";
    self.model=[[JishiDetailModel alloc]init];
    
    [self setBarButton];
    [self getData];
    [self createMyTableView];
    // Do any additional setup after loading the view.
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

-(void)getData
{
    
    //__weak JishiDetailVC *weakSelf=self;
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://app.api.niuche.com/modi/topic/detail?topic_id=%ld",(long)self.detailID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.model setValuesForKeysWithDictionary:responseObject[@"data"]];
   
        //NSLog(@"%@",self.model.content);
        
        [self.myTableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


-(void)createMyTableView
{
    self.myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-64) style:UITableViewStyleGrouped];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    [self.view addSubview:self.myTableView];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"JishiDetailCell1" bundle:nil] forCellReuseIdentifier:@"ID1"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0&&indexPath.row==0)
    {
        JishiDetailCell1 * cell=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ID1"];
        if(!cell)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"JishiDetailCell1" owner:self options:nil] firstObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setCellWithModel:self.model];
        return cell;
    }else if (indexPath.section==1&&indexPath.row==0)
    {
        JishiDetailCell2 * cell=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ID2"];
        if(!cell)
        {
            cell= [[JishiDetailCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID2"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setCellWithModel:self.model];
        return cell;
    }
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0&&indexPath.row==0)
    {
        return 60;
    }else if (indexPath.section==1&&indexPath.row==0)
    {
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGRect frame_H = [self.model.content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        NSArray * imageURLArray=self.model.imgs;
        int lineNum=(int)((imageURLArray.count-1)/3)+1;
        
        return (frame_H.size.height+lineNum*105+10);
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
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
