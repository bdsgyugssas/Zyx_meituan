//
//  MTMerchantController.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTMerchantController.h"
#import "MTMerchant.h"
#import "MTMerchantCell.h"
#import "MTMerchantF.h"
#import "MTMerchantChoseView.h"
#import "PersonPlace.h"
#import "MTMapViewController.h"

#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"

#import "MTDBTool.h"


@interface MTMerchantController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  下拉刷新控件
 */
@property (weak, nonatomic) MJRefreshGifHeader *header;

@property (weak, nonatomic) UITableView *tableView;

@property (weak, nonatomic) UISegmentedControl *segmentedControl;
/**
 *  加载的所有商家模型
 */
@property (strong, nonatomic) NSArray *allMerchant;
/**
 *  加载的所有商家模型在Cell中的尺寸
 */
@property (strong, nonatomic) NSMutableArray *allMerchantF;
/**
 *  加载的所有打折商家模型
 */
@property (strong, nonatomic) NSArray *allOnSaleMerchant;
/**
 *  加载的所有打折商家模型在Cell中的尺寸
 */
@property (strong, nonatomic) NSMutableArray *allOnSaleMerchantF;
/** 显示位置的Label  */
@property (weak, nonatomic) UILabel *placeLabel;
@end

@implementation MTMerchantController
#pragma maek -懒加载
- (NSMutableArray *)allMerchantF
{
    if (_allMerchantF==nil) {
        _allMerchantF=[NSMutableArray array];
    }
    return _allMerchantF;

}
- (NSMutableArray *)allOnSaleMerchantF
{
    if (_allOnSaleMerchantF==nil) {
        _allOnSaleMerchantF=[NSMutableArray array];
    }
    return _allOnSaleMerchantF;
    
}

#pragma mark -生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航栏
    [self setupNav];
    //设置界面
    [self initView];
    
}

#pragma mark -私有方法
/**
 *  设置界面
 */
- (void)initView
{
    //添加选择视图
    [self addChoseView];
    //添加tableView
    [self addTableView];
    //添加tableViewHeader
    [self addTableHeaderView];
    //添加下拉刷新控件
    [self addTableViewHeader];


}
/**
 *  添加选择视图
 */
- (void)addChoseView
{
    MTMerchantChoseView *choseView=[MTMerchantChoseView merchantChoseView];

    choseView.frame=CGRectMake(0, 64, self.view.width, 40);
    [self.view addSubview:choseView];
    
    

}
/**
 *  添加下拉刷新控件
 */
- (void)addTableViewHeader
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
 *  添加tableView
 */
- (void)addTableView
{
    UITableView *tableView=[[UITableView alloc]init];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.x=0;
    tableView.y=104;
    tableView.width=self.view.width;
    tableView.height=self.view.height;
    tableView.contentSize=CGSizeMake(0, 1000);
 
    [self.view addSubview:tableView];
    self.tableView=tableView;
    
 }
/**
 *  添加TableHeaderView
 */
- (void)addTableHeaderView
{
    UIView *headerView=[[UIView alloc]init];
    headerView.frame=CGRectMake(0, 0, self.view.width, 30);
    headerView.backgroundColor=RGB(231, 231, 231);
    
    UILabel *label=[[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:12];
    [label setTextColor:RGB(160, 160, 160)];
    label.textAlignment=NSTextAlignmentLeft;
    label.frame=CGRectMake(4, 7, self.view.width-30, 15);
    self.placeLabel=label;
    
    UIButton *button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"icon_dellist_locate_refresh"] forState:UIControlStateNormal];
    button.frame=CGRectMake(self.view.width-20, 7, 16, 16);
    [button addTarget:self action:@selector(loadMerchantDataWithButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:button];
    [headerView addSubview:label];
    
    self.tableView.tableHeaderView=headerView;

}
/**
 *  设置导航栏
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithimage:@"icon_map_highlighted" highlightedImage:@"icon_map_highlighted" target:self action:@selector(loadMap)];
    

    NSArray *items=@[@"全部商家",@"优惠商家"];
    UISegmentedControl *segmentedControl=[[UISegmentedControl alloc]initWithItems:items];
    segmentedControl.tintColor=RGB(33, 192, 174);
    segmentedControl.selectedSegmentIndex=0;
    [segmentedControl addTarget:self action:@selector(loadDataWithSegment) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView=segmentedControl;
    self.segmentedControl=segmentedControl;
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithimage:@"icon_search_selected_old" highlightedImage:nil];
    
    
}
#pragma mark -监听方法
/**
 *  加载地图数据
 */
- (void)loadMap
{
    MTMapViewController *mapViewController=[[MTMapViewController alloc]init];
    [self presentViewController:mapViewController animated:YES completion:nil];
    if (self.segmentedControl.selectedSegmentIndex==0) {
        //加载全部商家
        mapViewController.merchants=self.allMerchant;
    }else {
        //加载优惠商家
        mapViewController.merchants=self.allOnSaleMerchant;
    
    }
    
}
/**
 *  根据Segment的变化加载
 */
- (void)loadDataWithSegment
{

    if (self.segmentedControl.selectedSegmentIndex==0) {
        [self.tableView reloadData];
    }else{
        [self.tableView reloadData];
    }
}
/**
 *  下拉刷新加载数据
 */
- (void)loadData
{
    //刚进入是全部加载
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loadAllMerchantData];
        [self loadCouponMerchantData];
        [self getRegionData];
    });
    
    //之后下拉刷新判断是哪一个，进行加载。
    if (self.segmentedControl.selectedSegmentIndex==0) {
        [self loadAllMerchantData];
    }else{
        [self loadCouponMerchantData];
    }
    

    
}
/**
 *  地址按钮点击加载数据
 */
- (void)loadMerchantDataWithButtonClick
{
    [self.header beginRefreshing];
    if (self.segmentedControl.selectedSegmentIndex==0) {
        [self loadAllMerchantData];
    }else{
        [self loadCouponMerchantData];
    }

}
/**
 *  加载全部商家
 */
- (void)loadAllMerchantData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *str=@"http://api.meituan.com/group/v1/poi/select/cate/-1?__skck=c8a86f38931f8d49dbaadc416db7b31e&__skcy=fbZJPpnfkjL%2B0TP7zeSAv5PZGJQ%3D&__skno=EC657955-239C-4859-AEC4-638ED788F6F5&__skts=1448270783.947057&__skua=aa2f54f5c6c780ca8db3e6bc888c26c9&__vhost=api.mobile.meituan.com&areaId=-1&channelId=3&ci=1&cityId=1&client=iphone&coupon=all&limit=20&movieBundleVersion=100&msid=3E4594D1-0237-4061-AE9E-08655D3B64F82015-11-23-16-2614&mypos=40.080957%2C116.314201&offset=0&sort=smart&userid=234078849&utm_campaign=AgroupBgroupD100Gmerchant&utm_content=54D37CD3EA7BD9B0EECC296A729208EDCBA1CC133CE00FA6CDE3529E7FD2D22D&utm_medium=iphone&utm_source=AppStore&utm_term=6.1.1&uuid=54D37CD3EA7BD9B0EECC296A729208EDCBA1CC133CE00FA6CDE3529E7FD2D22D&version_name=6.1.1";
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *array=responseObject[@"data"];
        [MTDBTool saveMerchants:array type:MerchantTypeDefault];
        
        self.allMerchant=[MTMerchant mj_objectArrayWithKeyValuesArray:array];
        for (MTMerchant *merchant in self.allMerchant) {
            MTMerchantF *merchantF=[[MTMerchantF alloc]init];
            merchantF.merchant=merchant;
            [self.allMerchantF addObject:merchantF];
        }

        [self.tableView reloadData];
        [self.header endRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];

}
/**
 *  加载优惠商家
 */
- (void)loadCouponMerchantData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *str=@"http://api.meituan.com/group/v1/poi/select/cate/-1?__skck=c8a86f38931f8d49dbaadc416db7b31e&__skcy=fxzTatrfizufQVe6P3BVKsR4nx0%3D&__skno=EECBC282-2E08-4530-B865-F062969C4DE2&__skts=1448271210.871466&__skua=aa2f54f5c6c780ca8db3e6bc888c26c9&__vhost=api.mobile.meituan.com&areaId=-1&channelId=3&ci=1&cityId=1&client=iphone&coupon=hasgroup%7Cchoosesitting&limit=20&movieBundleVersion=100&msid=3E4594D1-0237-4061-AE9E-08655D3B64F82015-11-23-16-2614&mypos=40.080880%2C116.314305&offset=0&sort=smart&userid=234078849&utm_campaign=AgroupBgroupD100Gmerchant&utm_content=54D37CD3EA7BD9B0EECC296A729208EDCBA1CC133CE00FA6CDE3529E7FD2D22D&utm_medium=iphone&utm_source=AppStore&utm_term=6.1.1&uuid=54D37CD3EA7BD9B0EECC296A729208EDCBA1CC133CE00FA6CDE3529E7FD2D22D&version_name=6.1.1";
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        NSArray *array=responseObject[@"data"];
        [MTDBTool saveMerchants:array type:MerchantTypeOnSale];

        self.allOnSaleMerchant=[MTMerchant mj_objectArrayWithKeyValuesArray:array];
        for (MTMerchant *merchant in self.allOnSaleMerchant) {
            MTMerchantF *merchantF=[[MTMerchantF alloc]init];
            merchantF.merchant=merchant;
            [self.allOnSaleMerchantF addObject:merchantF];
        }
        [self.tableView reloadData];
        [self.header endRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];



}
/**
 *  加载区域信息
 */
- (void)getRegionData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *str=@"http://api.meituan.com/group/v1/city/latlng/40.079675,116.308090?__skck=c8a86f38931f8d49dbaadc416db7b31e&__skcy=hvd9fMjLDFkH%2FLXyo1%2FKPXve2dw%3D&__skno=CEBE6C5F-0C89-42BB-863E-442D63061E0B&__skts=1448270783.787282&__skua=aa2f54f5c6c780ca8db3e6bc888c26c9&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=3E4594D1-0237-4061-AE9E-08655D3B64F82015-11-23-16-2614&tag=1&userid=234078849&utm_campaign=AgroupBgroupD100Gmerchant&utm_content=54D37CD3EA7BD9B0EECC296A729208EDCBA1CC133CE00FA6CDE3529E7FD2D22D&utm_medium=iphone&utm_source=AppStore&utm_term=6.1.1&uuid=54D37CD3EA7BD9B0EECC296A729208EDCBA1CC133CE00FA6CDE3529E7FD2D22D&version_name=6.1.1";
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dict=responseObject[@"data"];
        PersonPlace *place=[PersonPlace mj_objectWithKeyValues:dict];
        self.placeLabel.text=[NSString stringWithFormat:@"当前位置:%@%@",place.district,place.detail];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentedControl.selectedSegmentIndex==0) {
        return self.allMerchant.count;
    }else if(self.segmentedControl.selectedSegmentIndex==1){
        return self.allOnSaleMerchant.count;
    }
    
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentedControl.selectedSegmentIndex==0) {
        MTMerchantCell *cell=[MTMerchantCell cellWithTableView:tableView];
        cell.merchantF=self.allMerchantF[indexPath.row];
        return cell;
    }else{
        MTMerchantCell *cell=[MTMerchantCell cellWithTableView:tableView];
        cell.merchantF=self.allOnSaleMerchantF[indexPath.row];
        return cell;
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark -UITableViewDelegate
@end
