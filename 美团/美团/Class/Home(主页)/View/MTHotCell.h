//
//  MTHotCell.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTCityGroupF;

@interface MTHotCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  热门城市
 */
@property (strong, nonatomic) NSArray *hotCities;
/**
 *  各个按钮的尺寸
 */
@property (strong, nonatomic) MTCityGroupF *cityGroupF;


@end
