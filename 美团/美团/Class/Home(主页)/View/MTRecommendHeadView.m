//
//  MTRecommendHeadView.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTRecommendHeadView.h"

@implementation MTRecommendHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=RGB(200, 200, 200);
        UILabel *label=[[UILabel alloc]init];
        label.text=@"  猜你喜欢";
        label.font=[UIFont boldSystemFontOfSize:16];
        label.backgroundColor=[UIColor whiteColor];
        [self addSubview:label];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UILabel *label=self.subviews[0];
    
    label.frame=CGRectMake(0, 20, self.width, 30);

}

@end
