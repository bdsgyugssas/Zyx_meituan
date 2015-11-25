//
//  MTDiscountCell.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTDiscountCell.h"
#import "MTDiscountViewP1.h"
#import "MTDiscountViewP2.h"

#import "MTDiscountShop.h"

@interface MTDiscountCell ()

@property (strong, nonatomic) NSMutableArray *P1;

@property (strong, nonatomic) NSMutableArray *P2;
@end

@implementation MTDiscountCell

- (NSMutableArray *)P1
{
    if (_P1==nil) {
        _P1=[NSMutableArray array];
    }
    return _P1;

}

- (NSMutableArray *)P2
{
    if (_P2==nil) {
        _P2=[NSMutableArray array];
    }
    return _P2;
    
}

+ (MTDiscountCell *)discountCellWithTableView:(UITableView *)tableView
{
    NSString *identifier=@"Discount";
    MTDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[MTDiscountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor=RGB(200, 200, 200);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setDiscountShop:(NSArray *)discountShop
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.P1 removeAllObjects];
    [self.P2 removeAllObjects];
    
    _discountShop=discountShop;
    int i=0;
    for (MTDiscountShop *shop in discountShop) {
        if (i<5) {
            if (shop.position==1) {
                MTDiscountViewP1 *P1View=[MTDiscountViewP1 discountView1];
                P1View.shop=discountShop[i];
                [self addSubview:P1View];
                [self.P1 addObject:P1View];
                
            }else{
                MTDiscountViewP2 *P2View=[MTDiscountViewP2 discountView2];
                P2View.shop=discountShop[i];
                [self addSubview:P2View];
                [self.P2 addObject:P2View];
            }
            i++;
        }else{
            return;
        }

    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    MTDiscountViewP1 *p1View=self.P1[0];
    p1View.frame=CGRectMake(0, 20, self.width, 50);

    NSInteger count=self.P2.count;

    CGFloat ViewW=(self.width-1)/2;
    CGFloat ViewH=50;
    for (int i=0; i<count; i++) {
        MTDiscountViewP2 *p2View=self.P2[i];
        p2View.width=ViewW;
        p2View.height=ViewH;
        if(i%2==1){
          p2View.x=i%2*ViewW+1;
        }else{
          p2View.x=i%2*ViewW;
        }
        if(i/2==1){
            p2View.y=i/2*50+1+71;
        }else{
            p2View.y=i/2*50+71;
        }

    }


}

@end
