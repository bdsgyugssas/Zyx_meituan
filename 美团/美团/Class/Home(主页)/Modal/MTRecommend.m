//
//  MTRecommend.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTRecommend.h"

@implementation MTRecommend

- (void)setSquareimgurl:(NSString *)squareimgurl
{
    NSString *str=[squareimgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    
    _squareimgurl=str;
}

@end
