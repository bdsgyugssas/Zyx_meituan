//
//  MTMerchantController.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTMerchantController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MTMerchant.h"
#import "MJExtension.h"
#import "MTMerchantCell.h"
#import "MTMerchantF.h"
#import "MTLocationTool.h"


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

#pragma mark -生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航栏
    [self setupNav];
    //添加tableView
    [self addTableView];
    //添加tableViewHeader
    [self addTableHeaderView];
    
    //添加下拉刷新控件
    [self addTableViewHeader];
    
}

#pragma mark -私有方法
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
    tableView.y=0;
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
    NSLog(@"%s",__func__);
    UIView *headerView=[[UIView alloc]init];
    headerView.frame=CGRectMake(0, 0, self.view.width, 20);
    headerView.backgroundColor=RGB(231, 231, 231);
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"当前位置:";
    label.font=[UIFont systemFontOfSize:12];
    [label setTextColor:RGB(201, 201, 201)];
    label.textAlignment=NSTextAlignmentLeft;
    label.frame=CGRectMake(4, 5, self.view.width-30, 10);
    
    UIButton *button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"icon_dellist_locate_refresh"] forState:UIControlStateNormal];
    button.frame=CGRectMake(self.view.width-20, 5, 10, 10);
    [button addTarget:self action:@selector(loadMerchantData) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:button];
    [headerView addSubview:label];
    
    self.tableView.tableHeaderView=headerView;

}
/**
 *  设置导航栏
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithimage:@"icon_map_highlighted" highlightedImage:@"icon_map_highlighted"];

    NSArray *items=@[@"全部商家",@"优惠商家"];
    UISegmentedControl *segmentedControl=[[UISegmentedControl alloc]initWithItems:items];
    segmentedControl.tintColor=RGB(33, 192, 174);
    segmentedControl.selectedSegmentIndex=0;
    self.navigationItem.titleView=segmentedControl;
    self.segmentedControl=segmentedControl;
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithimage:@"icon_search_selected_old" highlightedImage:nil];
    
    
}
#pragma mark -监听方法
- (void)loadData
{

}

- (void)loadMerchantData
{
    if (self.segmentedControl.selectedSegmentIndex==0) {
        [self loadAllMerchantData];
        MTLocationTool *tool=[MTLocationTool sharedLocationTool];
        [tool getAddress];
        
    }else{
        NSLog(@"加载优惠商家");
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
        self.allMerchant=[MTMerchant mj_objectArrayWithKeyValuesArray:array];
        
        for (MTMerchant *merchant in self.allMerchant) {
            MTMerchantF *merchantF=[[MTMerchantF alloc]init];
            merchantF.merchant=merchant;
            [self.allMerchantF addObject:merchantF];
        }

        [self.tableView reloadData];
        
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
        NSLog(@"%@",responseObject);
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
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentedControl.selectedSegmentIndex==0) {
        return self.allMerchant.count;
    }else{
        return 100;
    }
    
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
         NSLog(@"%@",cell.merchantF);
        return cell;
    }else{
        
        static NSString *identifier=@"Cell1";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark -UITableViewDelegate
@end
