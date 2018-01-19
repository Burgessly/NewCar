//
//  NewFeatureController.m
//  NewCar
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "NewFeatureController.h"
#import "NewFeatureCell.h"
@interface NewFeatureController ()

@property (nonatomic,strong) NSArray * picArray;
@property (nonatomic,strong) UIPageControl * control;
@end

@implementation NewFeatureController

static NSString *ID = @"cell";

-(instancetype)init
{
    UICollectionViewFlowLayout * layout= [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=[UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing=0;
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:layout];
}











- (void)viewDidLoad {
    [super viewDidLoad];
    self.picArray=@[@"one@2x.png",@"two@2x.png"];
    
    
    [self.collectionView registerClass:[NewFeatureCell class] forCellWithReuseIdentifier:ID];
    
    self.collectionView.pagingEnabled=YES;
    self.collectionView.bounces=NO;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    
    [self setUpPageControl];
    
}

-(void)setUpPageControl
{
    UIPageControl * control=[[UIPageControl alloc]init];
    control.numberOfPages=2;
    control.pageIndicatorTintColor=[UIColor blackColor];
    control.currentPageIndicatorTintColor=[UIColor whiteColor];
    control.center=CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height);
    _control=control;
    [self.view addSubview:control];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page=scrollView.contentOffset.x/scrollView.bounds.size.width+0.5;
    _control.currentPage=page;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewFeatureCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.image=[UIImage imageNamed:self.picArray[indexPath.row]];
    
    [cell setIndexPath:indexPath count:2];
    
    return cell;
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



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
