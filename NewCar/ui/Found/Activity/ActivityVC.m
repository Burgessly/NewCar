//
//  ActivityVC.m
//  NewCar
//
//  Created by qianfeng on 15/12/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ActivityVC.h"
#import "ActivityModel.h"
#import "ActivityCell.h"
#import "ActivityWebView.h"
@interface ActivityVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,assign) int currentPage;
@end

@implementation ActivityVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"优惠活动";
   
    [self setBarButton];
    
    [self getData];
    
    [self setMyTableView];
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

-(void)getData
{
    self.dataArray=[[NSMutableArray alloc]init];
    
    __weak ActivityVC *weadSelf = self;
    
    [GetData getDataFormUrl:@"http://app.api.niuche.com/modi/activity/get?page=1&count=20" andResponsedSuccesss:^(id responseObj) {
        
        NSArray * array=responseObj[@"activity_list"];
        
        for(NSDictionary * dict in array)
        {
            ActivityModel * model=[[ActivityModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:model];
        }
        
        [weadSelf.myTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
        [weadSelf.myTableView reloadData];
        
        
    }];
}

-(void)setMyTableView
{
    self.myTableView = [[UITableView alloc]init];
    
    self.myTableView.frame = CGRectMake(0, 0, screenWidth, screenHeight-64);
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"ActivityCell" bundle:nil] forCellReuseIdentifier:@"mm"];
    
    __weak ActivityVC *weadSelf = self;
    
    UIView * footView=[[UIView alloc]init];
    
    self.myTableView.tableFooterView=footView;
    
    
    //添加头部和尾部拉动刷新
    [self.myTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        weadSelf.currentPage = 1;
        
        [weadSelf.dataArray removeAllObjects];
        
        [weadSelf getData];
        
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"mm";
    
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ActivityCell" owner:self options:nil] firstObject];
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    [cell setCellWithModel:self.dataArray[indexPath.row]];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityWebView * activityWebView=[[ActivityWebView alloc]init];
    
    activityWebView.model=self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:activityWebView animated:YES];
}






-(void)leftButtonClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
