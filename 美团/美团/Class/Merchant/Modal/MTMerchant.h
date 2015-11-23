//
//  MTMerchant.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTMerchant : NSObject
/**
 *  商家的名字
 */
@property (copy,nonatomic) NSString *name;
/**
 *  纬度
 */
@property (assign,nonatomic) double lat;
/**
 *  经度
 */
@property (assign,nonatomic) double lng;
/**
 *  类别
 */
@property (copy,nonatomic) NSString *cateName;
/**
 *  区域
 */
@property (copy,nonatomic) NSString *areaName;
/**
 *  点评数
 */
@property (assign, nonatomic) int markNumbers;
/**
 *  人均消费
 */
@property (assign, nonatomic) int avgPrice;
/**
 *  商家图片
 */
@property (copy,nonatomic) NSString *frontImg;
/**
 *  商家距离
 */
@property (assign,nonatomic) double distance;

@end
