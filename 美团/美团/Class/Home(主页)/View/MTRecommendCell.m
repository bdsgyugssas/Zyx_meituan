//
//  MTRecommendCell.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTRecommendCell.h"
#import "MTRecommend.h"
#import "MTRecommendView.h"

@implementation MTRecommendCell

+ (MTRecommendCell *)recommendCellWithTableView:(UITableView *)tableView
{
    NSString *identifier=@"recommend";
    MTRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[MTRecommendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

    
    }
    return cell;
}

- (void)setShop:(MTRecommend *)shop
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _shop=shop;
    
    MTRecommendView *view=[MTRecommendView recommendView];
    view.shop=shop;
    [self addSubview:view];
}

- (void)layoutSubviews
{

    [super layoutSubviews];
    MTRecommendView *view=self.subviews[0];
    view.frame=CGRectMake(0, 0, self.width, 80);
}


@end
