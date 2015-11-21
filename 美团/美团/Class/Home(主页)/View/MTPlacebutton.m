//
//  MTPlacebutton.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTPlacebutton.h"

@implementation MTPlacebutton

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {

        [self setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
        

    }
    return self;

}

- (void)setPlace:(NSString *)place
{
    _place=place;
    
    [self setTitle:place forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.height=30;
    self.width=30;

}

@end
