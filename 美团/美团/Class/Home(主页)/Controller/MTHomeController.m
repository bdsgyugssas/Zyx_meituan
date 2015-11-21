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

@interface MTHomeController ()

@end

@implementation MTHomeController



- (void)viewDidLoad {
    [super viewDidLoad];
    [NotificationCenter addObserver:self selector:@selector(ChooseCity) name:@"switchCity" object:nil];
    // Do any additional setup after loading the view.
    // 设置导航栏
    [self steupNav];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark -私有方法
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
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:placeButton];
    self.navigationItem.leftBarButtonItem=left;
    
    
    

}
#pragma mark -监听方法
- (void) ChooseCity
{
    MTCityController *controller=[[MTCityController alloc]init];
    controller.view.backgroundColor=RandomColor;
    
    UINavigationController *ctr=[[UINavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:ctr animated:YES completion:nil];
    
}
/**
 *  按下切换城市按钮
 */
- (void)placeButtonClick:(UIButton *)button
{
    MTPlaceView *placeView=[MTPlaceView placeView];
    placeView.width=self.view.width;
    placeView.height=600;
    [self.view addSubview:placeView];
    
}



@end
