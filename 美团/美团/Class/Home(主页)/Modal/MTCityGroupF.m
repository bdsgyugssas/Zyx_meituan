//
//  MTCityGroupF.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/22.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTCityGroupF.h"
#import "MTCityGroup.h"

@implementation MTCityGroupF

- (void)setCityGroup:(MTCityGroup *)cityGroup
{
    _cityGroup=cityGroup;
    
    NSUInteger count=cityGroup.cities.count;
    
    CGFloat cellMargin=10;
    CGFloat cellW=(ScreenW-4*cellMargin)/3;
    CGFloat cellH=20;
    
    NSMutableArray *array=[NSMutableArray array];
    for (int i=0; i<count; i++) {
        CGFloat x=i%3*(cellMargin+cellW)+cellMargin;
        CGFloat y=i/3*(cellH+cellMargin)+cellMargin;
        CGFloat width=cellW;
        CGFloat height=cellH;
        CGRect frame=CGRectMake(x, y, width, height);
        [array addObject:[NSValue valueWithCGRect:frame]];
        
        if (i==count-1) {
            self.cellH=CGRectGetMaxY(frame)+cellMargin;
        }
    }

    self.buttonFrame=array;

}

@end
