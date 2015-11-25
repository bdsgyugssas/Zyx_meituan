//
//  MTDiscountShop.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTDiscountShop : NSObject

/** 位置  */
@property (assign, nonatomic) int position;
/** 主标题颜色  */
@property (copy,nonatomic) NSString *typeface_color;
/** 主标题  */
@property (copy,nonatomic) NSString *maintitle;
/** 副标题  */
@property (copy,nonatomic) NSString *deputytitle;
/** 图片  */
@property (copy,nonatomic) NSString *imageurl;

@end
