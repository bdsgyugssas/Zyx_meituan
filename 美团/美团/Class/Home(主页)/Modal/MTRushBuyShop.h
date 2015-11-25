//
//  MTRushBuyShop.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//  抢购商家模型

#import <Foundation/Foundation.h>

@interface MTRushBuyShop : NSObject

/** 活动价  */
@property (assign, nonatomic) int campaignprice;
/** 原价  */
@property (assign, nonatomic) int price;
/** 店家图片  */
@property (copy,nonatomic) NSString *mdcLogoUrl;

@end
