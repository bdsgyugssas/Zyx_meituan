//
//  MTRushBuyCell.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTRushBuyCell.h"
#import "MTRushBuyShop.h"
#import "MTRushBuyShopView.h"
#import "MTRushBuyEvent.h"

#import "UIImageView+WebCache.h"

@interface MTRushBuyCell ()

@property (strong, nonatomic) NSMutableArray *shops;

@property (weak, nonatomic) UIImageView *activityView;

@property (weak, nonatomic) UIView *view1;
@end

@implementation MTRushBuyCell

+ (instancetype)rushViewCellOfTableView:(UITableView *)tableView
{
    NSString *identifier=@"Rush";
    MTRushBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[MTRushBuyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor=RGB(200, 200, 200);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;


    }
    
    return cell;

}

- (NSMutableArray *)shops
{
    if (_shops==nil) {
        _shops=[NSMutableArray array];
    }
    return _shops;
}


- (void)setRushBuyShops:(NSArray *)rushBuyShops
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.shops removeAllObjects];
    
    _rushBuyShops=rushBuyShops;
   
    for (MTRushBuyShop *shop in rushBuyShops) {
        MTRushBuyShopView *view=[MTRushBuyShopView rushBuyShopView];
        view.shop=shop;
        [self addSubview:view];
        [self.shops addObject:view];
    }
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    [self addSubview:view];
    self.view1=view;


}

- (void)setEvent:(MTRushBuyEvent *)event
{
    
    _event=event;
    UIImageView *imageview=[[UIImageView alloc]init];
    NSString *str=[event.activityImgUrl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [imageview sd_setImageWithURL:[NSURL URLWithString:str]];

    [self addSubview:imageview];
    self.activityView=imageview;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count=self.shops.count;
    
    CGFloat ViewW=self.width/count;
    
    for (int i=0; i<count; i++) {
        MTRushBuyShopView *view=self.shops[i];
        view.width=ViewW;
        view.x=i*ViewW;
        view.y=50;

        
    }
    
    self.activityView.frame=CGRectMake(10, 20, 130, 30);
    
    self.view1.frame=CGRectMake(0, 20, self.width, 30);
    
    
}

@end
