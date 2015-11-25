//
//  MTMerchantChoseView.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/24.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTMerchantButton;
typedef enum {
    
    MTMerchantButtonAll,
    MTMerchantButtonAllCity,
    MTMerchantButtonIntelligence,
    
} MTMerchantButtonType;

@interface MTMerchantChoseView : UIView

+ (MTMerchantChoseView *)merchantChoseView;

@property (strong, nonatomic) MTMerchantButton *selectedButton;


@end
