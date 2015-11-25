//
//  MTRecommend.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTRecommend : NSObject


/** 位置  */
@property (copy,nonatomic) NSString *range;
/** 主标题  */
@property (copy,nonatomic) NSString *mtitle;
/** 姓名  */
@property (copy,nonatomic) NSString *mname;
/** 图片  */
@property (copy,nonatomic) NSString *squareimgurl;
/** 价格  */
@property (assign,nonatomic) double price;
/** 已售数量  */
@property (assign,nonatomic) long long solds;
/** 坐标  */
@property (copy,nonatomic) NSString *mlls;
/** 距离  */
@property (assign,nonatomic) double distance;



@end
