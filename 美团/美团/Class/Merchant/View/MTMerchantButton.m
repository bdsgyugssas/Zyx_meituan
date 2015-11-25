//
//  MTMerchantButton.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/24.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTMerchantButton.h"

@implementation MTMerchantButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"icon_arrow_dropdown_normal"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"icon_arrow_dropdown_selected"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:navigationBarColor forState:UIControlStateSelected];
    }
    return self;

}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    //[self sizeToFit];


}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.centerX=self.width/2;
    self.titleLabel.centerY=self.height/2;
    
    self.imageView.width=self.imageView.height=10;
    self.imageView.x=self.width-self.currentImage.size.width;
    self.imageView.centerY=self.height/2;

}


@end
