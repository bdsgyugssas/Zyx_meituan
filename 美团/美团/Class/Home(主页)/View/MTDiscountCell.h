//
//  MTDiscountCell.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTDiscountCell : UITableViewCell
/** 折扣商家  */
@property (strong, nonatomic) NSArray *discountShop;

+ (MTDiscountCell *)discountCellWithTableView:(UITableView *)tableView;

@end
