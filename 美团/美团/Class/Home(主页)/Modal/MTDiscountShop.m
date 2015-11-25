//
//  MTDiscountShop.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTDiscountShop.h"

@implementation MTDiscountShop


- (void)setImageurl:(NSString *)imageurl
{
    NSString *str=[imageurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    
    _imageurl=str;
}


@end
