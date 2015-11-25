//
//  City.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonPlace : NSObject
/** 城市名字 */
@property (strong, nonatomic) NSString *city;
/** 具体位置 */
@property (strong, nonatomic) NSString *detail;
/**  辖区 */
@property (strong, nonatomic) NSString *district;
/** 省份  */
@property (strong, nonatomic) NSString *province;
/** 纬度  */
@property (assign, nonatomic) double lat;
/** 经度  */
@property (assign, nonatomic) double lng;


@end
