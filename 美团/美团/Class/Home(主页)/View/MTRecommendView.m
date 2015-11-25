//
//  MTRecommendView.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTRecommendView.h"
#import "MTRecommend.h"
#import "UIImageView+WebCache.h"

@interface MTRecommendView ()
@property (weak, nonatomic) IBOutlet UIImageView *squareimgurl;
@property (weak, nonatomic) IBOutlet UILabel *mnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pieceLabel;
@property (weak, nonatomic) IBOutlet UILabel *soldsLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;


@end

@implementation MTRecommendView

+ (MTRecommendView *)recommendView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MTRecommendView" owner:nil options:nil] lastObject];
}

- (void)setShop:(MTRecommend *)shop
{
    _shop=shop;
    
    [self.squareimgurl sd_setImageWithURL:[NSURL URLWithString:shop.squareimgurl]];
    
    self.mnameLabel.text=shop.mname;
    
    self.mtitleLabel.text=[NSString stringWithFormat:@"[%@]%@",shop.range,shop.mtitle];
    self.mtitleLabel.font=[UIFont systemFontOfSize:12];
    self.mtitleLabel.textColor=RGB(200, 200, 200);
    self.mtitleLabel.numberOfLines=0;
    
    self.soldsLabel.text=[NSString stringWithFormat:@"已售%lld",shop.solds];
    self.soldsLabel.font=[UIFont systemFontOfSize:12];
    self.soldsLabel.textColor=RGB(200, 200, 200);

    
    
    self.pieceLabel.text=[NSString stringWithFormat:@"￥%.1f",shop.price];
    self.pieceLabel.textColor=navigationBarColor;


}

@end
