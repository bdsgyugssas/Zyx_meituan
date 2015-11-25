//
//  MTRecommendCell.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTRecommend;

@interface MTRecommendCell : UITableViewCell

+ (MTRecommendCell *)recommendCellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) MTRecommend *shop;

@end
