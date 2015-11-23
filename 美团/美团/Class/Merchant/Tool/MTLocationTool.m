//
//  MTLocationTool.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTLocationTool.h"
#import <CoreLocation/CoreLocation.h>

@interface MTLocationTool() <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *manager;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@property (strong, nonatomic) CLLocation *location;


@end

@implementation MTLocationTool

static MTLocationTool *_tool=nil;

+ (instancetype)sharedLocationTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       _tool=[[self alloc]init];
    });

    return _tool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool=[super allocWithZone:zone];
    });
    return _tool;
}

- (void)startLocation
{
    CLLocationManager *manager=[[CLLocationManager alloc]init];
    
    manager.desiredAccuracy=kCLLocationAccuracyBest;
    manager.delegate=self;
    
    if ([UIDevice currentDevice].systemVersion.doubleValue>=8.0) {
        [manager requestAlwaysAuthorization];
    }else{
        [manager startUpdatingLocation];
    }
    
    self.manager=manager;
}


- (double)distanceToCurrentplaceWithlongitude:(double )longitude latitude:(double)latitude
{

    
    CLLocation *locationF=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    double distance=[self.location distanceFromLocation:locationF];
    NSLog(@"%@,%@",self.location,locationF);
    return distance;
}

#pragma mark -<CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
 
    switch (status) {
        case  kCLAuthorizationStatusAuthorizedWhenInUse:
        case  kCLAuthorizationStatusAuthorizedAlways: {
            [self.manager startUpdatingLocation];
            break;
        }
        default:
            break;
    }

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{

    CLLocation *location=[locations firstObject];
    self.location=location;
    self.coordinate=location.coordinate;
    [self.manager stopUpdatingLocation];

}

- (NSString *)getAddress
{
    [self startLocation];
    
    CLGeocoder *geoCoder=[[CLGeocoder alloc]init];
    
    [geoCoder reverseGeocodeLocation:self.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {

        CLPlacemark *placeMark=[placemarks firstObject];

        NSLog(@"%@",placeMark);

        
    }];


    return nil;

}
@end
