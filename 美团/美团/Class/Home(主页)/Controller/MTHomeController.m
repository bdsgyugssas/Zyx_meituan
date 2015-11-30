//
//  MTHomeController.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTHomeController.h"
#import "MTPlacebutton.h"
#import "MTPlaceView.h"
#import "MTCityController.h"
#import "MTCityRegion.h"
#import "MTHomeCategoryViewCell.h"
#import "MTMapViewController.h"
#import "URL.h"
#import "MTRushBuyCell.h"
#import "MTRushBuyEvent.h"

#import "MTDiscountCell.h"
#import "MTDiscountShop.h"

#import "MTRushBuyShop.h"

#import "MTRecommend.h"
#import "MTRecommendHeadView.h"
#import "MTRecommendCell.h"

#import "MJExtension.h"
#import "MJRefresh.h"
#import "AFNetworking.h"


@interface MTHomeController () <MTCityControllerdelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) MTPlacebutton *leftButton;

@property (weak, nonatomic) MTPlaceView *placeView;
/**
 *  全部城市信息
 */
@property (strong, nonatomic) NSArray *cities;
/** 下拉刷新控件  */
@property (weak, nonatomic) MJRefreshGifHeader *header;
/**   抢购商家  */
@property (strong, nonatomic) NSArray *rushShops;
/**   抢购活动  */
@property (strong, nonatomic) MTRushBuyEvent *rushEvent;
/**   折扣商家  */
@property (strong, nonatomic) NSArray *discountShops;
/**   推荐商家  */
@property (strong, nonatomic) NSArray *recommendShops;

@end

@implementation MTHomeController

#pragma mark -懒加载
- (MTPlaceView *)placeView
{

    if (_placeView==nil) {
        MTPlaceView *placeView=[MTPlaceView placeView];
        placeView.width=self.view.width;
        placeView.height=600;
        [self.view addSubview:placeView];
        _placeView=placeView;
    }
    return _placeView;
    
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册观察者
    [self addNotification];
    // 设置导航栏
    [self steupNav];
    // 获取所有城市信息
    [self loadCitiesData];
    self.view.backgroundColor=[UIColor blackColor];
    // 添加下拉刷新控件
    [self addRefresh];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [NotificationCenter removeObserver:self];
}


#pragma mark -私有方法
/**
 *  添加下拉刷新控件
 */
- (void)addRefresh
{
    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    NSMutableArray *array=[NSMutableArray array];
    NSMutableArray *array1=[NSMutableArray array];
    
    UIImage *image1=[UIImage imageNamed:@"icon_listheader_animation_1"];
    UIImage *image2=[UIImage imageNamed:@"icon_listheader_animation_2"];
    
    [array addObject:image1];
    
    [array1 addObject:image1];
    [array1 addObject:image2];
    
    [header setImages:array forState:MJRefreshStatePulling];
    [header setImages:array1 forState:MJRefreshStateRefreshing];
    
    self.tableView.header=header;
    self.header=header;
    [self.header beginRefreshing];
}

/**
 *  注册观察者
 */
- (void)addNotification
{
    [NotificationCenter addObserver:self selector:@selector(ChooseCity) name:@"switchCity" object:nil];
    [NotificationCenter addObserver:self selector:@selector(regionClick:) name:@"regionClick" object:nil];
    [NotificationCenter addObserver:self selector:@selector(hotCityClick:) name:@"hotCityClick" object:nil];
    
}
/**
 *  加载选择城市的相关信息
 */
- (void)loadShopData:(NSString *)string
{
    NSLog(@"加载城市数据%@",string);

}
/**
 *  获得点击城市的区域模型
 */
- (MTCityRegion *)achieveCityRegionWithPlace:(NSString *)place
{
  
    for (MTCityRegion *cityRegion in self.cities) {
        if ([cityRegion.name isEqualToString:place]) {
            return cityRegion;
        }
    }
    return nil;
    
}
/**
 *  设置城市信息
 */
- (void)loadCitiesData
{
    NSString *citiesPath=[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    NSArray *cities=[NSArray arrayWithContentsOfFile:citiesPath];
    self.cities=[MTCityRegion mj_objectArrayWithKeyValuesArray:cities];
    
}

/**
 *  设置导航栏
 */
- (void)steupNav
{
   //设置右侧按钮
    UIBarButtonItem *right=[UIBarButtonItem  itemWithimage:@"icon_district" highlightedImage:@"icon_district_highlighted"];
    self.navigationItem.rightBarButtonItem=right;
    
    
    //设置左侧按钮
    MTPlacebutton *placeButton=[[MTPlacebutton alloc]init];
    placeButton.place=@"北京";
    [placeButton addTarget:self action:@selector(placeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:placeButton];
    self.leftButton=placeButton;
    

}
#pragma mark -加载数据
/**
 *   加载促销商家
 */
- (void)loadData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval=10;
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    [manager GET:RushBuyString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dataarray=(responseObject[@"data"])[@"deals"];
        NSArray *RushShopArray=[MTRushBuyShop mj_objectArrayWithKeyValuesArray:dataarray];
        self.rushShops=RushShopArray;
        NSDictionary *activityRush=responseObject[@"data"];
        self.rushEvent=[MTRushBuyEvent mj_objectWithKeyValues:activityRush];
        
        [self loadDiscountData];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"加载失败");
    }];
}
/**
 *  加载折扣信息
 */
- (void)loadDiscountData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval=10;
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    [manager GET:discountString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dataArray=responseObject[@"data"];
        self.discountShops=[MTDiscountShop mj_objectArrayWithKeyValuesArray:dataArray];
        [self loadrecommendData];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"加载失败");
    }];


}
/**
 *  加载推荐商家数据
 */
- (void)loadrecommendData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval=10;
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    [manager GET:recommendString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dataArray=responseObject[@"data"];
        self.recommendShops=[MTRecommend mj_objectArrayWithKeyValuesArray:dataArray];
        NSLog(@"%lu",(unsigned long)self.recommendShops.count);
        [self.header endRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"加载失败");
    }];

}
#pragma mark -监听方法
/**
 *  点击热门区域
 */
- (void)hotCityClick:(NSNotification *)notification
{
    
    self.placeView.hidden=YES;
    self.leftButton.selected=!self.leftButton.isSelected;
    NSString *city=notification.userInfo[@"hotcity"];
    self.leftButton.place=city;
    [self loadShopData:city];
}
/**
 *  选择区域
 */
- (void)regionClick:(NSNotification *)notification
{
    self.placeView.hidden=YES;
    self.leftButton.selected=!self.leftButton.isSelected;
    [self loadShopData:notification.userInfo[@"region"]];
 
}

- (void)ChooseCity
{
    MTCityController *controller=[[MTCityController alloc]init];
    controller.delegate=self;
    
    UINavigationController *ctr=[[UINavigationController alloc]initWithRootViewController:controller];
    
    [self presentViewController:ctr animated:YES completion:nil];
    
}
/**
 *  按下切换城市按钮
 */
- (void)placeButtonClick:(MTPlacebutton *)button
{
    self.leftButton.selected=!self.leftButton.isSelected;

    self.placeView.cityRegion=[self achieveCityRegionWithPlace:button.place];

    if (self.leftButton.selected) {
        self.placeView.hidden=NO;
    }else {
        self.placeView.hidden=YES;
    }

    
}

#pragma mark -MTCityControllerDelegate

- (void)loadingCityData:(NSString *)city
{
    self.placeView.hidden=YES;
    self.leftButton.selected=!self.leftButton.isSelected;
    self.leftButton.place=city;
    [self loadShopData:city];
    
}

#pragma mark -tableViewdatascoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }else{
        return self.recommendShops.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            MTHomeCategoryViewCell *cell=[MTHomeCategoryViewCell cellWithTableView:tableView];
            return cell;
        }else if(indexPath.row==1){
            MTRushBuyCell *cell=[MTRushBuyCell rushViewCellOfTableView:tableView];
            cell.rushBuyShops=self.rushShops;
            cell.event=self.rushEvent;
            return cell;
        }else if (indexPath.row==2){
            if (self.discountShops) {
                MTDiscountCell *cell=[MTDiscountCell discountCellWithTableView:tableView];
                cell.discountShop=self.discountShops;
                return cell;
            }else {
                static NSString *cellIndentifier = @"nomorecell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }

    }else {
        if (self.recommendShops) {
            MTRecommendCell *cell=[MTRecommendCell recommendCellWithTableView:tableView];
            cell.shop=self.recommendShops[indexPath.row];
            return cell;
        }else {
            static NSString *cellIndentifier = @"nomorecell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        

        
    }
       return nil;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 150;
        }else if (indexPath.row==1){
            return 120;
        }else if (indexPath.row==2){
            return 172;
        } 
    }else{
      return 80;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return [[MTRecommendHeadView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 50)];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 50;
    }
    return 0;

}

@end
