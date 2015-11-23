//
//  MTMerchantF.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTMerchantF.h"
#import "MTMerchant.h"

/** 边缘距离  */
#define Margin 10

@implementation MTMerchantF


- (void)setMerchant:(MTMerchant *)merchant
{
    _merchant=merchant;
   
    //商家照片尺寸
    CGFloat photoViewX=Margin;
    CGFloat photoViewY=Margin;
    CGFloat photoViewW=100;
    CGFloat photoViewH=80;
    self.photoViewF=CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
    
    //商家姓名尺寸
    CGFloat nameLabelX=Margin+CGRectGetMaxX(self.photoViewF);
    CGFloat nameLabelY=Margin;
    CGSize nameLabelSize=[merchant.name sizeWithfont:namelabelFont];
    self.nameLabelF=(CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    
    //商家类别尺寸
    CGSize categoryLabelSize=[merchant.cateName sizeWithfont:categorylabelFont];
    CGFloat categoryLabelX=Margin+CGRectGetMaxX(self.photoViewF);
    CGFloat categoryLabelY=CGRectGetMaxY(self.photoViewF)-categoryLabelSize.height;
    self.categoryLabelF=(CGRect){{categoryLabelX,categoryLabelY},categoryLabelSize};
    
    //商家区域尺寸
    CGSize areaLabelSize=[merchant.areaName sizeWithfont:arealabelFont];
    CGFloat areaLabelX=Margin+CGRectGetMaxX(self.categoryLabelF);
    CGFloat areaLabelY=CGRectGetMaxY(self.photoViewF)-categoryLabelSize.height;
    self.areaLabelF=(CGRect){{areaLabelX,areaLabelY},areaLabelSize};
    
    //5星评价图尺寸
    CGFloat markViewW=100;
    CGFloat markViewH=20;
    CGFloat markViewX=nameLabelX;
    CGFloat markViewY=CGRectGetMaxY(self.nameLabelF)+Margin;
    self.markViewF=CGRectMake(markViewX, markViewY, markViewW, markViewH);
    
    //评价人数尺寸
    NSString *string=[NSString stringWithFormat:@"%d评价",merchant.markNumbers];
    CGSize markLabelSize=[string sizeWithfont:marklabelFont];
    CGFloat markLabelX=CGRectGetMaxX(self.markViewF)+Margin;
    CGFloat markLabelY=markViewY;
    self.markLabelF=(CGRect){{markLabelX, markLabelY},markLabelSize};
    
    //人均消费尺寸
    NSString *avgstring=[NSString stringWithFormat:@"人均￥%d",merchant.avgPrice];
    CGSize avgPriceLabelSize=[avgstring sizeWithfont:arealabelFont];
    CGFloat avgPriceLabelX=ScreenW-Margin-avgPriceLabelSize.width;
    CGFloat avgPriceLabelY=markViewY;
    self.avgPriceLabelF=(CGRect){{avgPriceLabelX, avgPriceLabelY},avgPriceLabelSize};
    
    //距离位置尺寸
    NSString *distancestring=[NSString stringWithFormat:@"距离%.1fKm",merchant.distance];
    CGSize distanceLabelLabelSize=[distancestring sizeWithfont:distancelabelFont];
    CGFloat distanceLabelLabelX=ScreenW-Margin-distanceLabelLabelSize.width;
    CGFloat distanceLabelLabelY=areaLabelY;
    self.distanceLabelF=(CGRect){{distanceLabelLabelX, distanceLabelLabelY},distanceLabelLabelSize};
    

}

@end
