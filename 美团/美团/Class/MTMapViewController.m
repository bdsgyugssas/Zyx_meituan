//
//  MTMapViewController.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/24.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <MapKit/MapKit.h>

#import "MTMerchant.h"

@interface MTMapViewController ()<MAMapViewDelegate>

@property (weak, nonatomic) MAMapView *mapView;

@end

@implementation MTMapViewController

static int i=0;

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //加载地图视图
    [self setupMapView];

    [self setupBackbutton];
    

}

- (void)setMerchants:(NSArray *)merchants
{
    _merchants=merchants;
    i=0;
    double spanLatMax=0; //地图的范围-纬度
    double spanLatMin=MAXFLOAT;
    double spanLngMax=0; //地图的范围-经度
    double spanLngMin=MAXFLOAT;
    for (MTMerchant *merchant in merchants) {
       
        double lat=merchant.lat;
        double lng=merchant.lng;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(lat, lng);
        pointAnnotation.title = merchant.name;
        pointAnnotation.subtitle = merchant.addr;
        [_mapView addAnnotation:pointAnnotation];
      
        //判断经纬度范围
       spanLatMax=spanLatMax<lat?lat:spanLatMax;
       spanLatMin=spanLatMin>lat?lat:spanLatMin;
       
       spanLngMax=spanLngMax<lng?lng:spanLngMax;
       spanLngMin=spanLngMin>lng?lng:spanLngMin;

    }
    double latt=(spanLatMax+spanLatMin)/2;
    double lngg=(spanLngMax+spanLngMin)/2;
    self.mapView.centerCoordinate=CLLocationCoordinate2DMake(latt, lngg);
    MACoordinateSpan span=MACoordinateSpanMake(spanLatMax-spanLatMin+0.25, spanLngMax-spanLngMin+0.25);
    self.mapView.region=MACoordinateRegionMake(self.mapView.centerCoordinate, span);
    

    
}

#pragma mark -私有方法
/**
 *  添加回退按钮
 */
- (void)setupBackbutton
{

    UIButton *button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=RGBA(46, 46, 46, 1);
    button.frame=CGRectMake(20, 20, 60, 30);
    [self.view addSubview:button];
    
}
/**
 *  加载地图视图
 */
- (void)setupMapView
{
    [MAMapServices sharedServices].apiKey=GaoDeKEY;
    
    MAMapView *mapView=[[MAMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    mapView.delegate=self;
   
    [self.view addSubview:mapView];
    self.mapView=mapView;

}
#pragma mark -监听方法
/**
 *  回退按钮点击
 */
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{


    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        //瞎写的，不是真正的按类别分的
        MTMerchant *merchant=self.merchants[i];
        NSString *cate=merchant.cateName;
        NSString *imageStr=@"";
        if ([cate isEqualToString:@"美发"]) {
            imageStr=@"icon_map_cateid_22";
        }else{
            imageStr=[NSString stringWithFormat:@"icon_map_cateid_%d",arc4random_uniform(9)];
        }
        annotationView.image=[UIImage imageNamed:imageStr];
        annotationView.size=CGSizeMake(40, 40);
        i++;
        return annotationView;
    }
    return nil;

}
@end
