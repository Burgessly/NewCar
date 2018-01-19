//
//  MineViewController.m
//  NiucheProduct
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MineViewController.h"
#import "TupianModel.h"
#import "TupianCell1.h"
#import "TupianCell2.h"
#import "DetailVC.h"
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * myTableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) int currentPage;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_define_large_bar_back_image@2x.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView * imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ipad_login_logo@2x.png"]];
    imageView.frame=CGRectMake(0, 0, 40, 30);
    self.navigationItem.titleView=imageView;
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.currentPage=1;
    self.dataArray=[NSMutableArray array];
    [self createTableView];
    
    [self getData];
    
}

-(void)getData
{
    
    __weak MineViewController *weakSelf=self;
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://api.ycapp.yiche.com/AppNews/GetAppNewsAlbumList?page=%d&length=20&platform=2",self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(self.currentPage==1)
        {
            [weakSelf.dataArray removeAllObjects];
        }
        
        NSArray * array=[operation.responseObject objectForKey:@"data"];
        
        for(NSDictionary * dict in array)
        {
            TupianModel * model=[[TupianModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.dataArray addObject:model];
        }
        
        [weakSelf.myTableView reloadData];
        //NSLog(@"%lu~~~~~~~",(unsigned long)self.dataArray.count);
        [weakSelf.myTableView footerEndRefreshing];
        [weakSelf.myTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}





-(void)createTableView
{
    self.myTableView=[[UITableView alloc]init];
    self.myTableView.frame=CGRectMake(0, 0, screenWidth, screenHeight-49-64);
    self.myTableView.dataSource=self;
    self.myTableView.delegate=self;
    [self.view addSubview:self.myTableView];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"TupianCell1" bundle:nil] forCellReuseIdentifier:@"ID1"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"TupianCell2" bundle:nil] forCellReuseIdentifier:@"ID2"];
    
    __weak MineViewController * weakSelf=self;
    [self.myTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
       
        weakSelf.currentPage=1;
        
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
    NSArray * picArray=[[self.dataArray[indexPath.row] picCover] componentsSeparatedByString:@";"];
    if(picArray.count==1)
    {
        TupianCell1 * cell=[tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if(!cell)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"TupianCell1" owner:self options:nil] firstObject];
        }
        [cell setCellWithModel:self.dataArray[indexPath.row]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if (picArray.count==3)
    {
        TupianCell2 * cell=[tableView dequeueReusableCellWithIdentifier:@"ID2"];
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
    NSArray * picArray=[[self.dataArray[indexPath.row] picCover] componentsSeparatedByString:@";"];
    if(picArray.count==1)
    {
        return 160;
    }else if(picArray.count==3)
    {
        return 140;
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailVC * dVC=[[DetailVC alloc]init];
    dVC.detailId=[self.dataArray[indexPath.row] newsId];
    
    [self presentViewController:dVC animated:YES completion:nil];
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
