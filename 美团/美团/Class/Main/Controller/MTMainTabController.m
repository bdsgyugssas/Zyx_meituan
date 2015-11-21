//
//  MTMainTabController.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTMainTabController.h"
#import "MTHomeController.h"
#import "MTNavController.h"

@interface MTMainTabController ()

@end

@implementation MTMainTabController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

      MTHomeController *controller1=[[MTHomeController alloc]init];
    [self addChildViewController:controller1 withimage:@"icon_tabbar_homepage" selectedImage:@"icon_tabbar_homepage_selected" title:@"团购"];
    UIViewController *controller2=[[UIViewController alloc]init];

    [self addChildViewController:controller2 withimage:@"icon_tabbar_onsite" selectedImage:@"icon_tabbar_onsite_selected" title:@"上门"];
    UIViewController *controller3=[[UIViewController alloc]init];

    [self addChildViewController:controller3 withimage:@"icon_tabbar_merchant_normal" selectedImage:@"icon_tabbar_merchant_normal_selected" title:@"商家"];
    UIViewController *controller4=[[UIViewController alloc]init];

    [self addChildViewController:controller4 withimage:@"icon_tabbar_mine" selectedImage:@"icon_tabbar_mine_selected" title:@"我的"];
    UIViewController *controller5=[[UIViewController alloc]init];

    [self addChildViewController:controller5 withimage:@"icon_tabbar_misc" selectedImage:@"icon_tabbar_misc_selected" title:@"更多"];


    
}

#pragma mark -私有方法
- (void)addChildViewController:(UIViewController *)controller withimage:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    controller.tabBarItem.image=[UIImage imageNamed:image];
    controller.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.title=title;
    controller.view.backgroundColor=[UIColor whiteColor];
    
    MTNavController *ctr=[[MTNavController alloc]initWithRootViewController:controller];
    [self addChildViewController:ctr];
}

@end
