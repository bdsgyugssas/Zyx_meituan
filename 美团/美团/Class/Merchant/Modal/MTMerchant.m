//
//  MTMerchant.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTMerchant.h"
#import "MTLocationManager.h"
#import <CoreLocation/CoreLocation.h>


@implementation MTMerchant

- (double)distance
{
    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:self.lat longitude:self.lng];
    CLLocationDistance distanceF=[location distanceFromLocation:[MTLocationManager locationManager].location];
    return distanceF/1000;

}

@end
