//
//  MTLocationManager.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;
@interface MTLocationManager : NSObject

+ (MTLocationManager *)locationManager;

-(void)start;

@property (strong, nonatomic) CLLocation *location;

@end
