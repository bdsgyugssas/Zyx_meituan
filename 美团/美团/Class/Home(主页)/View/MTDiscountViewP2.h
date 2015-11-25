//
//  MTDiscountViewP2.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTDiscountShop;

@interface MTDiscountViewP2 : UIView

+ (MTDiscountViewP2 *)discountView2;

@property (strong, nonatomic) MTDiscountShop *shop;

@end
