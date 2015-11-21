//
//  MTCurrentCity.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTCurrentCity.h"

@interface MTCurrentCity ()

@property (weak, nonatomic) UIButton *button;

@end


@implementation MTCurrentCity



- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor=[UIColor redColor];
        UIButton *button=[[UIButton alloc]init];
        button.backgroundColor=RandomColor;
        [button addTarget:self action:@selector(switchCity) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.button=button;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.button.width=280;
    self.button.height=44;
    self.button.centerX=self.centerX;
    self.button.centerY=self.height/2;
    
}


/**
 *  点击切换按钮,发出通知
 */
- (void)switchCity
{
    [NotificationCenter postNotificationName:@"switchCity" object:nil];

}
@end
