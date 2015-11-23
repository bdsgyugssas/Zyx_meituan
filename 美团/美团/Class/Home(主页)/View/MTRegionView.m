//
//  MTRegionView.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTRegionView.h"

@implementation MTRegionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
    }
    return self;
}


- (void)setRegions:(NSArray *)regions
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _regions=regions;

    NSUInteger count=regions.count;
    NSLog(@"%lu",(unsigned long)count);
    for (int i=0; i<count; i++) {
        UIButton *button=[[UIButton alloc]init];
        [button setTitle:[regions[i] objectForKey:@"name"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.backgroundColor=[UIColor whiteColor];
        [button addTarget:self action:@selector(regionClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count=self.subviews.count;
    
    CGFloat cellMargin=10;
    CGFloat cellW=(ScreenW-4*cellMargin)/3;
    CGFloat cellH=20;
    CGFloat H=0;
    
    for (int i=0; i<count; i++) {
        CGFloat width=cellW;
        CGFloat height=cellH;
        CGFloat x=i%3*(cellMargin+cellW)+cellMargin;
        CGFloat y=i/3*(cellH+cellMargin)+cellMargin;
        UIButton *button=self.subviews[i];
        button.frame=CGRectMake(x, y, width, height);
        if (i==count-1) {
            H=CGRectGetMaxY(button.frame)+cellMargin;
        }
    }
    
    self.contentSize=CGSizeMake(ScreenW, H);
    

}

#pragma mark -监听方法
- (void)regionClick:(UIButton *)button
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"region"]=button.currentTitle;
    
    [NotificationCenter postNotificationName:@"regionClick" object:nil userInfo:dict];
 
}

@end
