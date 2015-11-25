//
//  MTOnePageCategoryView.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/22.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTOnePageCategoryView.h"
#import "MTCagetoryButton.h"

@implementation MTOnePageCategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self addButtonWithImage:@"icon_homepage_foodCategory" title:@"美食" type:CategoryButtonFood];
        [self addButtonWithImage:@"icon_homepage_movieCategory"title:@"电影" type:CategoryButtonMovie];
        [self addButtonWithImage:@"icon_homepage_hotelCategory" title:@"酒店"type:CategoryButtonhotel];
        [self addButtonWithImage:@"icon_homepage_KTVCategory" title:@"KTY"type:CategoryButtonKTV];
        [self addButtonWithImage:@"icon_homepage_beautyCategory"title:@"丽人" type:CategoryButtonbeauty];
        [self addButtonWithImage:@"icon_homepage_entertainmentCategory"title:@"休闲娱乐" type:CategoryButtonentertainment];
        [self addButtonWithImage:@"icon_homepage_foottreatCategory" title:@"足疗"type:CategoryButtonfoottreat];
        [self addButtonWithImage:@"icon_homepage_lifeServiceCategory" title:@"生活服务"type:CategoryButtonlifeService];
    }
    
    return self;

}

- (void)addButtonWithImage:(NSString *)image title:(NSString *)title type:(CategoryButtonType)type
{
    MTCagetoryButton *button=[[MTCagetoryButton alloc]init];
    button.tag=type;

    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self addSubview:button];
}
- (void)buttonClick:(UIButton *)button
{
    NSLog(@"%ld",(long)button.tag);

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW=self.width/4;
    CGFloat btnH=self.height/2;
    NSUInteger count=self.subviews.count;
    for (int i=0; i<count; i++) {
        UIButton *button=self.subviews[i];
        button.x=i%4*btnW;
        button.y=i/4*btnH;
        button.width=btnW;
        button.height=btnH;
        
    }

    
}

@end
