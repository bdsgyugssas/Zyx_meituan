//
//  MTLocationManager.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTLocationManager.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MTLocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *manager;

@end

@implementation MTLocationManager

- (void)start
{
    NSLog(@"%d",[CLLocationManager locationServicesEnabled]);
    CLLocationManager *manager=[[CLLocationManager alloc]init];
    manager.desiredAccuracy=kCLLocationAccuracyBest;
    manager.distanceFilter=100;
    self.manager=manager;
    if ([UIDevice currentDevice].systemVersion.doubleValue>8.0) {
        [manager requestAlwaysAuthorization];
    }else{
        [manager startUpdatingLocation];
    }
    self.manager.delegate=self;
 

}

#pragma mark -CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
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
    CLLocation *location=[locations  lastObject];
    
    NSLog(@"%f,%f",location.coordinate.latitude,location.coordinate.longitude);

}
@end
