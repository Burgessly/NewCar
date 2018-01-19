//
//  ShouYeViewController.m
//  NiucheProduct
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ShouYeViewController.h"
#import "Type1Model.h"
#import "Type2Model.h"
#import "Type3Model.h"
#import "Type1Cell.h"
#import "Type2Cell.h"
#import "Type3Cell.h"
#import "JHRefresh.h"
#import "XiangqingViewController.h"
#import "XiangqingWebView.h"
#import "XiangqingType2VC.h"
#import "EGOCache.h"
#import "MJRefresh.h"
#import "GetDataArray.h"
@interface ShouYeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,assign) int currentPage;

@property(nonatomic,strong)DownLoadData *getDataResqest;

@property (nonatomic,strong) NSMutableArray *refreshImages;//刷新动画的图片数组
@property (nonatomic,strong) NSMutableArray *normalImages;//普通状态下的图片数组

@end

@implementation ShouYeViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.tabBarController.tabBar.hidden=NO;
    
    self.navigationController.navigationBar.hidden=NO;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ipad_login_logo@2x.png"]];
    imageView.frame=CGRectMake(0, 0, 40, 30);
    
    self.navigationItem.titleView=imageView;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_define_large_bar_back_image@2x.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.dataArray=[[NSMutableArray alloc]init];
    
 
    
    self.navigationController.navigationBar.translucent=NO;
    
    self.currentPage=1;
    
    //[self getData];
    
    //判断是否缓存
    [self getDataFormCache];
    
    //设置MainTableview
    [self setMyTableView];
    
    //[self.myTableView headerBeginRefreshing];

}

-(void)getDataFormCache
{
    if([[EGOCache globalCache] hasCacheForKey:@"Shouye"])
    {
        id cachdata=[[EGOCache globalCache]plistForKey:@"Shouye"];
        
        NSArray * array=[cachdata objectForKey:@"data"];
        
        self.dataArray=[GetDataArray getDataModelArrayWithArray:array];
        
        [self.myTableView footerEndRefreshing];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView reloadData];
    }else{
        [self getData];
    }
    
}








#pragma mark-获取数据
-(void)getData
{

    
    
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    
    __weak ShouYeViewController *weadSelf = self;
    
    [manager GET:[NSString stringWithFormat:@"http://app.api.niuche.com/modi/mix_list?page=%d&count=20",self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(weadSelf.currentPage==1)
        {
            [self.dataArray removeAllObjects];
            [[EGOCache globalCache]setPlist:operation.responseObject forKey:@"Shouye"];
        }
        
        NSArray * array=[operation.responseObject objectForKey:@"data"];
        
        NSArray * dataModelArray=[GetDataArray getDataModelArrayWithArray:array];
        
        [self.dataArray addObjectsFromArray:dataModelArray];
        
        NSLog(@"%ld*********",self.dataArray.count);
        
        [weadSelf.myTableView footerEndRefreshing];
        [weadSelf.myTableView.mj_header endRefreshing];
        [self.myTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    

}

#pragma mark-设置表单
-(void)setMyTableView
{
    self.myTableView = [[UITableView alloc]init];
    
    self.myTableView.frame = CGRectMake(0, 0, screenWidth, screenHeight-49-64);
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
    
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //注册对应的xibCell
    [self.myTableView registerNib:[UINib nibWithNibName:@"Type1Cell" bundle:nil] forCellReuseIdentifier:@"type1"];
    
        [self.myTableView registerNib:[UINib nibWithNibName:@"Type2Cell" bundle:nil] forCellReuseIdentifier:@"type2"];
    
        [self.myTableView registerNib:[UINib nibWithNibName:@"Type3Cell" bundle:nil] forCellReuseIdentifier:@"type3"];
    
    __weak ShouYeViewController *weadSelf = self;
    //添加头部和尾部拉动刷新
//    [self.myTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
//        
//        weadSelf.currentPage = 1;
//        
//        [weadSelf.dataArray removeAllObjects];
//        
//        [weadSelf getData];
//        
//    }];
    
    
    MJRefreshGifHeader * header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [header setImages:self.refreshImages forState:MJRefreshStateRefreshing];
    
    [header setImages:self.normalImages forState:MJRefreshStateIdle];
    
    [header setImages:self.refreshImages forState:MJRefreshStatePulling];
    
    header.lastUpdatedTimeLabel.hidden=YES;
    
    header.stateLabel.hidden=NO;
    
    self.myTableView.mj_header=header;
    
    [self.myTableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        weadSelf.currentPage ++;
        
        [weadSelf getData];
        
    }];

}

-(void)loadNewData
{
    self.currentPage = 1;

    [self getData];
}


#pragma mark-表单协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([[self.dataArray[indexPath.row] valueForKey:@"type"] integerValue]) {
        case 1:
        {
            static NSString *ID = @"type1";
            
            Type1Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"Type1Cell" owner:self options:nil] firstObject];
            }
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            [cell setCellWithModel:self.dataArray[indexPath.row]];
            
            return cell;
        
        }
        break;
            
            
        case 2:
        {
            static NSString *ID = @"type2";
            
            Type2Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"Type2Cell" owner:self options:nil] firstObject];
            }
            
            [cell setCellWithModel:self.dataArray[indexPath.row]];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
            break;
            
            
        case 3:
        {
            static NSString *ID = @"type3";
            
            Type3Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"Type3Cell" owner:self options:nil] firstObject];
            }
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            [cell setCellWithModel:self.dataArray[indexPath.row]];
            
            return cell;
            
        }
            break;
            
            
            
        default:
            break;
    }
    
    return nil;

   
}

#pragma mark 页面跳转
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([[self.dataArray[indexPath.row] valueForKey:@"type"] integerValue]) {
        case 1:
        {
            XiangqingViewController * xiangqingVC=[[XiangqingViewController alloc]init];
            xiangqingVC.hidesBottomBarWhenPushed=YES;
            Type1Model * model=self.dataArray[indexPath.row];
         xiangqingVC.id1=[model.modi_case[@"id"] integerValue];
                        
            [self.navigationController pushViewController:xiangqingVC animated:YES];
            
        }
            break;
            
            
        case 2:
        {
            XiangqingType2VC * xiangqingVC=[[XiangqingType2VC alloc]init];
            xiangqingVC.hidesBottomBarWhenPushed=YES;
            
            Type2Model * model=self.dataArray[indexPath.row];
            
            xiangqingVC.id1=[model.article[@"id"] integerValue];
            
            [self.navigationController pushViewController:xiangqingVC animated:YES];
            
        }
            break;
            
            
        case 3:
        {
            XiangqingWebView * xiangqingWebView=[[XiangqingWebView alloc]init];
            xiangqingWebView.hidesBottomBarWhenPushed=YES;
            
            Type3Model * model=self.dataArray[indexPath.row];
            
            xiangqingWebView.id1=[model.video[@"id"] integerValue];
            
            xiangqingWebView.type=[model.video[@"type"] integerValue];
            
            [self.navigationController pushViewController:xiangqingWebView animated:YES];
        }
            break;
            
            
            
        default:
            break;
    }


}



/**
 *  @author   (๑• . •๑) xiaoqiB, 15-11-24 15:11:06
 *  普通状态下的图片
 */
- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"hone_loading_image01@2x.png"]];
        [self.normalImages addObject:image];
    }
    return _normalImages;
}
//正在刷新状态下的图片
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [[NSMutableArray alloc] init];
        //				循环添加图片
        for (NSUInteger i = 1; i<=9; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"hone_loading_image0%lu@2x.png", (unsigned long)i]];
            [self.refreshImages addObject:image];
        }
        
    }
    return _refreshImages;
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
