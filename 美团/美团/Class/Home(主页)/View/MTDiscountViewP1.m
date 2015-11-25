//
//  MTDiscountViewP1.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTDiscountViewP1.h"
#import "MTDiscountShop.h"
#import "UIImageView+WebCache.h"

@interface MTDiscountViewP1 ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel *deputyTitle;
@end
@implementation MTDiscountViewP1

+ (MTDiscountViewP1 *)discountView1
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MTDiscountViewP1" owner:nil options:nil] lastObject];
}

- (void)setShop:(MTDiscountShop *)shop
{
    _shop=shop;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.imageurl]];
    
    self.mainTitle.text=shop.maintitle;
    self.mainTitle.textColor=[UIColor colorWithHexString:shop.typeface_color];

    self.deputyTitle.text=shop.deputytitle;
    self.deputyTitle.font=[UIFont systemFontOfSize:12];
    self.deputyTitle.textColor=RGB(200, 200, 200);
    
}

@end
