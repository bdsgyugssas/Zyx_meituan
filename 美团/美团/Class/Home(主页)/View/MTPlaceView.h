//
//  MTPlaceView.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTCityRegion;

@interface MTPlaceView : UIView

+ (instancetype)placeView;

@property (strong, nonatomic) MTCityRegion *cityRegion;


@end
