//
//  MTCityRegion.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/22.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCityRegion : NSObject
/**
 *  城市名字
 */
@property (strong, nonatomic) NSString *name;
/**
 *  包含区域
 */
@property (strong, nonatomic) NSArray *regions;


@end
