//
//  MTRushBuyEvent.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTRushBuyEvent : NSObject

/** 开始时间  */
@property (assign, nonatomic) long long start;
/** 结束时间  */
@property (assign, nonatomic) long long end;
/** 活动图片  */
@property (copy,nonatomic) NSString *activityImgUrl;
@end
