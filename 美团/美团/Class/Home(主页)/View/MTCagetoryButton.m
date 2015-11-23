//
//  MTCagetoryButton.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/22.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTCagetoryButton.h"

@implementation MTCagetoryButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.imageView.contentMode=UIViewContentModeScaleAspectFill;
        self.titleLabel.font=[UIFont systemFontOfSize:10];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.width=40;
            view.height=40;
            view.centerX=self.width/2;
            view.y=10;
        }else if ([view isKindOfClass:[UILabel class]]){
            UILabel *label=(UILabel *)view;
            label.width=50;
            label.height=20;
            label.centerX=self.width/2;
            label.y=50;
        }
    }

}

@end
