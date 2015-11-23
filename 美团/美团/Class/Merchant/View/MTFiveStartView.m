//
//  MTFiveStartView.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTFiveStartView.h"

@implementation MTFiveStartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        for (int i=0; i<5; i++) {
            UIImageView *imageView=[[UIImageView alloc]init];
            [self addSubview:imageView];
        }
    }
    return self;

}


- (void)setScores:(double)scores
{
    _scores=scores;
    
    
    int count=(int)scores;
    
    NSInteger allcount=self.subviews.count;
    if ((scores-(int)scores)==0) {
        for (int i=0; i<allcount; i++) {
            if (i<count) {
                UIImageView *imageView=self.subviews[i];
                imageView.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            }else {
                UIImageView *imageView=self.subviews[i];
                imageView.image=[UIImage imageNamed:@"icon_rating_star_not_picked"];
            }
        }
    }else{
        for (int i=0; i<allcount; i++) {
            if (i<count) {
                UIImageView *imageView=self.subviews[i];
                imageView.image=[UIImage imageNamed:@"icon_rating_star_picked"];
            }else if (i==count){
                UIImageView *imageView=self.subviews[i];
                imageView.image=[UIImage imageNamed:@"icon_rating_star_half"];
            }else{
                UIImageView *imageView=self.subviews[i];
                imageView.image=[UIImage imageNamed:@"icon_rating_star_not_picked"];
            
            }

        }

    }

}

- (void)setViewHeight:(CGFloat)ViewHeight
{
    _ViewHeight=ViewHeight;
    
    self.width=ViewHeight*5;
    self.height=ViewHeight;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i=0; i<5; i++) {
        UIImageView *imageView=self.subviews[i];
        imageView.x=i*self.height;
        imageView.y=0;
        imageView.width=imageView.height=self.height;
    }

}

@end
