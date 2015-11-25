//
//  MTMerchantCell.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTMerchantCell.h"
#import "MTMerchant.h"
#import "MTMerchantF.h"
#import "MTFiveStartView.h"
#import "UIImageView+WebCache.h"

@interface MTMerchantCell ()
/**
 *  商家图标
 */
@property (weak, nonatomic) UIImageView *photoView;
/**
 *  商家名称
 */
@property (weak, nonatomic) UILabel *nameLabel;
/**
 *  商家类别
 */
@property (weak, nonatomic) UILabel *categoryLabel;
/**
 *  商家区域
 */
@property (weak, nonatomic) UILabel *areaLabel;
/**
 *  商家距离
 */
@property (weak, nonatomic) UILabel *distanceLabel;
/**
 *  人均消费
 */
@property (weak, nonatomic) UILabel *avgPriceLabel;
/**
 *  评价图
 */
@property (weak, nonatomic) MTFiveStartView *fiveStartView;
/**
 *  评价人数
 */
@property (weak, nonatomic) UILabel *markLabel;


@end

@implementation MTMerchantCell

+ (MTMerchantCell *)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *identifier=@"Cell0";
    MTMerchantCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[MTMerchantCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageview=[[UIImageView alloc]init];
        [self addSubview:imageview];
        self.photoView=imageview;
        
        UILabel *nameLabel=[[UILabel alloc]init];
        nameLabel.font=namelabelFont;
        [self addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        
        UILabel *categoryLabel=[[UILabel alloc]init];
        categoryLabel.font=categorylabelFont;
        [categoryLabel setTextColor:RGB(189, 189, 189)];
        [self addSubview:categoryLabel];
        self.categoryLabel=categoryLabel;
        
        UILabel *areaLabel=[[UILabel alloc]init];
        areaLabel.font=arealabelFont;
        [areaLabel setTextColor:RGB(189, 189, 189)];
        [self addSubview:areaLabel];
        self.areaLabel=areaLabel;
        
        MTFiveStartView *fiveStartView=[[MTFiveStartView alloc]init];
        [self addSubview:fiveStartView];
        self.fiveStartView=fiveStartView;
        
        UILabel *markLabel=[[UILabel alloc]init];
        markLabel.font=marklabelFont;
        [markLabel setTextColor:RGB(189, 189, 189)];
        [self addSubview:markLabel];
        self.markLabel=markLabel;
        
        UILabel *avgPriceLabel=[[UILabel alloc]init];
        avgPriceLabel.font=avgPricelabelFont;
        [avgPriceLabel setTextColor:RGB(189, 189, 189)];
        [self addSubview:avgPriceLabel];
        self.avgPriceLabel=avgPriceLabel;
        
        UILabel *distanceLabel=[[UILabel alloc]init];
        distanceLabel.font=distancelabelFont;
        [distanceLabel setTextColor:RGB(189, 189, 189)];
        [self addSubview:distanceLabel];
        self.distanceLabel=distanceLabel;
        
        
    }
    return self;

}

- (void)setMerchantF:(MTMerchantF *)merchantF
{
    _merchantF=merchantF;
    MTMerchant *merchant=merchantF.merchant;
    
    self.photoView.frame=merchantF.photoViewF;
    NSString *str=[merchant.frontImg stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:str]];
    
    self.nameLabel.frame=merchantF.nameLabelF;
    self.nameLabel.text=merchant.name;
    
    self.categoryLabel.frame=merchantF.categoryLabelF;
    self.categoryLabel.text=merchant.cateName;
    
    self.areaLabel.frame=merchantF.areaLabelF;
    self.areaLabel.text=merchant.areaName;
    
    self.fiveStartView.frame=merchantF.markViewF;
    self.fiveStartView.scores=5.0;
    
    self.markLabel.frame=merchantF.markLabelF;
    self.markLabel.text=[NSString stringWithFormat:@"%d评价",merchant.markNumbers];
    
    if (merchant.avgPrice) {
        self.avgPriceLabel.hidden=NO;
        self.avgPriceLabel.frame=merchantF.avgPriceLabelF;
        self.avgPriceLabel.text=[NSString stringWithFormat:@"人均￥%d",merchant.avgPrice];
    }else{
        self.avgPriceLabel.hidden=YES;
    }
    
    self.distanceLabel.frame=merchantF.distanceLabelF;
    self.distanceLabel.text=[NSString stringWithFormat:@"距离%.1fKm",merchant.distance];
    

}

@end
