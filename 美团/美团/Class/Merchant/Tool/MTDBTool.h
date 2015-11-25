//
//  MTDBTool.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/24.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTDBTool : NSObject

+ (void)saveMerchants:(NSArray *)merchants type:(MerchantType)type;

+ (NSArray *)getDataWithType:(MerchantType)type;

@end
