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

        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        self.width=100;
        self.height=self.currentImage.size.height;
 
    }
    return self;

}

- (void)setPlace:(NSString *)place
{
    _place=place;
    
    [self setTitle:place forState:UIControlStateNormal];

}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.titleLabel.x=self.imageView.x;
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame);
    

}

@end
