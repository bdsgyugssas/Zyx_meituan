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
        self.backgroundColor=RGB(180, 180, 180);
        UIButton *button=[[UIButton alloc]init];
        button.backgroundColor=[UIColor whiteColor];
        [button addTarget:self action:@selector(switchCity) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:button];
        self.button=button;
    }
    return self;
}

- (void)setName:(NSString *)name
{
    _name=name;
    
    NSString *str=[NSString stringWithFormat:@"当前城市:%@",name];
    [self.button setTitle:str forState:UIControlStateNormal];

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
