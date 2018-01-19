//
//  JishiVC.m
//  NewCar
//
//  Created by qianfeng on 15/12/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JishiVC.h"
#import "JishiModel.h"
#import "JishiCell1.h"
#import "JishiCell2.h"
#import "JishiDetailVC.h"
@interface JishiVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * myTableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) int currentPage;
@end

@implementation JishiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"牛车集市";
    self.currentPage=1;
    self.dataArray=[NSMutableArray array];
    [self setBarButton];
    [self createTableView];
    [self getData];
    
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
    
    __weak JishiVC *weakSelf=self;
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://app.api.niuche.com/modi/topic_list?page=%d&count=20&order=0",self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(self.currentPage==1)
        {
             [weakSelf.dataArray removeAllObjects];
        }
        
        NSArray * array=[operation.responseObject objectForKey:@"data"];
        for(NSDictionary * dict in array)
        {
            JishiModel * model=[[JishiModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.dataArray addObject:model];
        }
        
        [weakSelf.myTableView reloadData];
        NSLog(@"%lu~~~~~~~",(unsigned long)self.dataArray.count);
        [weakSelf.myTableView footerEndRefreshing];
        [weakSelf.myTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
}

-(void)createTableView
{
    self.myTableView=[[UITableView alloc]init];
    self.myTableView.frame=CGRectMake(0, 0, screenWidth, screenHeight-64);
    self.myTableView.dataSource=self;
    self.myTableView.delegate=self;
    [self.view addSubview:self.myTableView];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"JishiCell1" bundle:nil] forCellReuseIdentifier:@"ID1"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"JishiCell2" bundle:nil] forCellReuseIdentifier:@"ID2"];
    
    __weak JishiVC * weakSelf=self;
    [self.myTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        weakSelf.currentPage=1;
       
        //[weakSelf.dataArray removeObjectsInRange:NSMakeRange(0, 20)];
        [weakSelf getData];
        
    }];
    
    [self.myTableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        weakSelf.currentPage ++;
        [weakSelf getData];
        
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cover=[self.dataArray[indexPath.row] cover];
    if([cover isEqualToString:@""])
    {
        JishiCell1 * cell=[tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if(!cell)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"JishiCell1" owner:self options:nil] firstObject];
        }
        [cell setCellWithModel:self.dataArray[indexPath.row]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        JishiCell2 * cell=[tableView dequeueReusableCellWithIdentifier:@"ID2"];
        if(!cell)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"TupianCell2" owner:self options:nil] firstObject];
        }
        [cell setCellWithModel:self.dataArray[indexPath.row]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    return nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JishiDetailVC * jishiDetailVC=[[JishiDetailVC alloc]init];
    JishiModel * model=self.dataArray[indexPath.row];
    jishiDetailVC.detailID=model.id1;
    jishiDetailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:jishiDetailVC animated:YES];
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
