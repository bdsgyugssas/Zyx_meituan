//
//  MTLocationTool.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTLocationTool : NSObject
/**
 *   计算给定的坐标和当前坐标的距离
 */
-(double)distanceToCurrentplaceWithlongitude:(double)longitude latitude:(double)latitude;
/**
 *  单例模式
 */
+(instancetype)sharedLocationTool;
/**
 *  开始定位
 */
-(void)startLocation;
/**
 *  获得当前坐标的地址
 */
- (NSString *)getAddress;
@end
