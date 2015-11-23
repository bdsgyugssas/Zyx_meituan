//
//  MTMerchantCell.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTMerchantF;

@interface MTMerchantCell : UITableViewCell

+ (MTMerchantCell *)cellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) MTMerchantF *merchantF;

@end
