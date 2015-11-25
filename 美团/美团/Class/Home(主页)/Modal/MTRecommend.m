//
//  MTRecommend.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTRecommend.h"
#import <CoreLocation/CoreLocation.h>
#import "MTLocationManager.h"

@implementation MTRecommend

- (void)setSquareimgurl:(NSString *)squareimgurl
{
    NSString *str=[squareimgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    
    _squareimgurl=str;
}


- (double)distance
{
    NSString *mlls=self.mlls;
    NSRange range;
    range=[mlls rangeOfString:@","];
    NSString *lat=[mlls substringToIndex:range.location];
    NSString *lng=[mlls substringFromIndex:range.location+range.length];
    
    CLLocation *locaton=[[CLLocation alloc]initWithLatitude:lat.doubleValue longitude:lng.doubleValue];
    
    return  [locaton distanceFromLocation:[MTLocationManager locationManager].location]/1000;
    

}
@end
