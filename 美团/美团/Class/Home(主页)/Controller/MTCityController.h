//
//  MTCityController.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MTCityControllerdelegate <NSObject>

- (void)loadingCityData:(NSString *)city;

@end

@interface MTCityController : UITableViewController

@property (weak, nonatomic) id <MTCityControllerdelegate>delegate;

@end
