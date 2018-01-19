//
//  MovicVC.m
//  NewCar
//
//  Created by qianfeng on 15/12/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MovicVC.h"
#import "Type3Cell.h"
#import "MovicModel.h"
#import "XiangqingWebView.h"
@interface MovicVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,assign) int currentPage;

@end

@implementation MovicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"改装视频";
    
    self.currentPage=1;
    
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
    
    __weak MovicVC *weadSelf = self;
    
    [GetData getDataFormUrl:[NSString stringWithFormat:@"http://app.api.niuche.com/modi/video_list?page=%d&count=20&order=0",self.currentPage] andResponsedSuccesss:^(id responseObj) {
        
        NSArray * array=responseObj[@"data"];
        
        for(NSDictionary * dict in array)
        {
            MovicModel * model=[[MovicModel alloc]init];
            
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
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"Type3Cell" bundle:nil] forCellReuseIdentifier:@"kk"];
    
    __weak MovicVC *weadSelf = self;
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
    static NSString *ID = @"kk";
    
    
    Type3Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"Type3Cell" owner:self options:nil] firstObject];
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    [cell setCellWithMovicModel:self.dataArray[indexPath.row]];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XiangqingWebView * xiangqingWebView=[[XiangqingWebView alloc]init];
    
    MovicModel * model=self.dataArray[indexPath.row];
    
    xiangqingWebView.id1=model.id1;
    
    xiangqingWebView.type=model.type;
    
    [self.navigationController pushViewController:xiangqingWebView animated:YES];


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
