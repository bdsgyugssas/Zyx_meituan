//
//  MTRushBuyShopView.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTRushBuyShopView.h"
#import "MTLabel.h"
#import "MTRushBuyShop.h"
#import "UIImageView+WebCache.h"

@interface MTRushBuyShopView ()
@property (weak, nonatomic) IBOutlet UIImageView *shopPhoto;
@property (weak, nonatomic) IBOutlet MTLabel *campaignLabel;
@property (weak, nonatomic) IBOutlet MTLabel *pieceLabel;

@end

@implementation MTRushBuyShopView



+ (instancetype)rushBuyShopView
{

    return [[[NSBundle mainBundle]loadNibNamed:@"MTRushBuyShopView" owner:nil options:nil] lastObject];
}

- (void)setShop:(MTRushBuyShop *)shop
{
    _shop=shop;
    self.campaignLabel.text=[NSString stringWithFormat:@"￥%d",shop.campaignprice];
    
    self.pieceLabel.text=[NSString stringWithFormat:@"￥%d",shop.price];
    self.pieceLabel.strikethrough=YES;

    [self.shopPhoto sd_setImageWithURL:[NSURL URLWithString:shop.mdcLogoUrl]];

}

@end
