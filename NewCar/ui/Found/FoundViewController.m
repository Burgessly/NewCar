//
//  FoundViewController.m
//  NiucheProduct
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FoundViewController.h"
#import "FoundModel.h"
#import "FoundPageCell.h"
#import "NiurenSayVC.h"
#import "JishiVC.h"
#import "MovicVC.h"
#import "ActivityVC.h"
@interface FoundViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * dataArray;


@property(nonatomic,strong)DownLoadData *getDataResqest;
@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_define_large_bar_back_image@2x.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.dataArray=[[NSMutableArray alloc]init];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView * imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ipad_login_logo@2x.png"]];
    imageView.frame=CGRectMake(0, 0, 40, 30);
    
    self.navigationItem.titleView=imageView;
    
    self.navigationController.navigationBar.translucent=NO;
    
    [self getData];
    
    //设置MainTableview
    [self setMyTableView];

    // Do any additional setup after loading the view.
}

#pragma mark-获取数据
-(void)getData
{
    self.dataArray=[[NSMutableArray alloc]init];
    
    __weak FoundViewController *weadSelf = self;
    
    [GetData getDataFormUrl:@"http://app.api.niuche.com/modi/discovery_page" andResponsedSuccesss:^(id responseObj) {

        
        NSArray * array=responseObj[@"data"][@"entry"];
        
        for(NSDictionary * dict in array)
        {
            FoundModel * model=[[FoundModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:model];
        }
        
        
        [weadSelf.myTableView reloadData];
        
    }];

    
}

#pragma mark-设置表单
-(void)setMyTableView
{
    self.myTableView = [[UITableView alloc]init];
    
    self.myTableView.frame = CGRectMake(0, 0, screenWidth, screenHeight-64-49);
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
    
    //注册对应的xibCell
    [self.myTableView registerNib:[UINib nibWithNibName:@"FoundPageCell" bundle:nil] forCellReuseIdentifier:@"FoundCell"];
    
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}


#pragma mark-表单协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"FoundCell";
    
    FoundPageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"FoundPageCell" owner:self options:nil] firstObject];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [cell setCellWithModel:self.dataArray[indexPath.row]];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NiurenSayVC * sayVC=[[NiurenSayVC alloc]init];
            sayVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:sayVC animated:YES];
        }
            break;
            
        case 1:
        {
            JishiVC * jishiVC=[[JishiVC alloc]init];
            jishiVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:jishiVC animated:YES];
        }
            break;
            
        case 2:
        {
            MovicVC * movicVC=[[MovicVC alloc]init];
            movicVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:movicVC animated:YES];
        }
            break;
            
        case 3:
        {
            ActivityVC * activityVC=[[ActivityVC alloc]init];
            activityVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:activityVC animated:YES];
        }
            break;
            
        default:
            break;
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
