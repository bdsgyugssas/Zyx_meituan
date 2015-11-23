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
#import "MJExtension.h"
#import "MTHomeCategoryViewCell.h"

@interface MTHomeController () <MTCityControllerdelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) MTPlacebutton *leftButton;

@property (weak, nonatomic) MTPlaceView *placeView;
/**
 *  全部城市信息
 */
@property (strong, nonatomic) NSArray *cities;

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
    [NotificationCenter addObserver:self selector:@selector(ChooseCity) name:@"switchCity" object:nil];
    [NotificationCenter addObserver:self selector:@selector(regionClick:) name:@"regionClick" object:nil];
    [NotificationCenter addObserver:self selector:@selector(hotCityClick:) name:@"hotCityClick" object:nil];

    // 设置导航栏
    [self steupNav];
    // 获取所有城市信息
    [self loadCitiesData];
    //
    

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
    NSLog(@"%@",button.place);
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        MTHomeCategoryViewCell *cell=[MTHomeCategoryViewCell cellWithTableView:tableView];
        return cell;
        
    }else {
        return nil ;
    }

}

#pragma mark -tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 150;
    }else{
        return 44;
    }


}

@end
