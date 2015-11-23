//
//  MTHotCell.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTHotCell.h"
#import "MTCityGroupF.h"



@implementation MTHotCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{

    static NSString *identifier=@"HotCell";
    MTHotCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[MTHotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor=[UIColor grayColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}



- (void)setHotCities:(NSArray *)hotCities
{
    _hotCities=hotCities;
    if (self.subviews.count!=0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    NSUInteger count=hotCities.count;
    for (int i=0; i<count; i++) {
        UIButton *button=[[UIButton alloc]init];
        button.backgroundColor=[UIColor whiteColor];
        [button setTitle: hotCities[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(placeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count=self.subviews.count;

    for (int i=0; i<count; i++) {
        UIView *view=self.subviews[i];
        if ([view isKindOfClass:[UIButton class]]) {
            view.frame=((NSValue*)self.cityGroupF.buttonFrame[i]).CGRectValue;
        }

    }


}

#pragma mark -监听方法
- (void)placeClick:(UIButton *)button
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"hotcity"]=button.currentTitle;
    [NotificationCenter postNotificationName:@"hotCityClick" object:nil userInfo:dict];
    
}
@end
