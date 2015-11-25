//
//  MTLocationManager.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface MTLocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *manager;

@end

@implementation MTLocationManager

static id mtlocationManager;

+ (MTLocationManager *)locationManager
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       mtlocationManager=[[self alloc]init];
    });
    return mtlocationManager;

}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mtlocationManager=[super allocWithZone:zone];
    });
    return mtlocationManager;
}


- (void)start
{
    NSLog(@"%d",[CLLocationManager locationServicesEnabled]);
    CLLocationManager *manager=[[CLLocationManager alloc]init];
    manager.desiredAccuracy=kCLLocationAccuracyBest;
    manager.distanceFilter=100;
    self.manager=manager;
    
    if ([UIDevice currentDevice].systemVersion.doubleValue>=8.0) {
        [manager requestAlwaysAuthorization];
        [manager requestWhenInUseAuthorization];
    }else{
        [manager startUpdatingLocation];
    }
    self.manager.delegate=self;

}

#pragma mark -CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
  
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:{
            [manager requestAlwaysAuthorization];
            break;
        }
            
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied: {
            NSLog(@"定位失败");
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            [self.manager startUpdatingLocation];
            break;
        }
        default: {
            break;
        }
    }

}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
//    self.location=[locations  lastObject];
    self.location=[[CLLocation alloc]initWithLatitude:Lat longitude:Lng];
    
}
@end
