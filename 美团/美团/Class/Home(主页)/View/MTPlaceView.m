//
//  MTPlaceView.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTPlaceView.h"
#import "MTRegionView.h"
#import "MTCurrentCity.h"

@interface MTPlaceView ()

@property (weak, nonatomic) MTRegionView *regionView;

@property (weak, nonatomic) MTCurrentCity *currentCity;

@property (weak, nonatomic) UIButton *button;

@end

@implementation MTPlaceView


+ (instancetype)placeView
{

    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=RGBA(0, 0, 0, 0.1);
        
        //放置一个蒙面
        UIButton *button=[[UIButton alloc]init];
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.button=button;
        
        //加载区域视图
        MTRegionView *scrollView=[[MTRegionView alloc]init];
        scrollView.backgroundColor=RandomColor;
        [self addSubview:scrollView];
        self.regionView=scrollView;
        

        MTCurrentCity *currentCity=[[MTCurrentCity alloc]init];
        [self addSubview:currentCity];
        self.currentCity =currentCity;
        
    }
    return self;

}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.button.frame=self.bounds;
    
    self.regionView.width=self.width;
    self.regionView.height=150;
    
    self.currentCity.height=100;
    self.currentCity.width=self.width;
    self.currentCity.y=self.regionView.height;

    

}

#pragma mark -
- (void)buttonClick
{
    [self removeFromSuperview];


}
@end
