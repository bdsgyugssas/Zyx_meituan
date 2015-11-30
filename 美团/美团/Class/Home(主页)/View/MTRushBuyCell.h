//
//  MTRushBuyCell.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTRushBuyEvent;
@interface MTRushBuyCell : UITableViewCell

+ (instancetype)rushViewCellOfTableView:(UITableView *)tableView;

@property (strong, nonatomic) NSArray *rushBuyShops;

@property (strong, nonatomic) MTRushBuyEvent *event;

@end
