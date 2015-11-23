//
//  MTMerchantF.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTMerchant;
/** namelabel字体  */
#define namelabelFont  [UIFont systemFontOfSize:15]
/** categorylabel字体  */
#define categorylabelFont  [UIFont systemFontOfSize:15]
/** arealabel字体  */
#define arealabelFont  [UIFont systemFontOfSize:15]
/** amarklabel字体  */
#define marklabelFont  [UIFont systemFontOfSize:15]
/** avgPricelabel字体  */
#define avgPricelabelFont  [UIFont systemFontOfSize:15]
/** distancelabel字体  */
#define distancelabelFont  [UIFont systemFontOfSize:15]
@interface MTMerchantF : NSObject

/**
 *  商家
 */
@property (strong, nonatomic) MTMerchant *merchant;

/**
 *  商家图标Frame
 */
@property (assign, nonatomic) CGRect photoViewF;
/**
 *  商家名称Frame
 */
@property (assign, nonatomic) CGRect nameLabelF;
/**
 *  商家类别Frame
 */
@property (assign, nonatomic) CGRect categoryLabelF;
/**
 *  商家区域Frame
 */
@property (assign, nonatomic) CGRect areaLabelF;
/**
 *  商家距离Frame
 */
@property (assign, nonatomic) CGRect distanceLabelF;
/**
 *  人均消费Frame
 */
@property (assign, nonatomic) CGRect avgPriceLabelF;
/**
 *  5星评价图Frame
 */
@property (assign, nonatomic) CGRect markViewF;
/**
 *  评价人数Frame
 */
@property (assign, nonatomic) CGRect markLabelF;


@end
