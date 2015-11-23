//
//  MTMerchant.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/23.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTMerchant.h"
#import "MTLocationTool.h"

@implementation MTMerchant

- (double )distance
{
    MTLocationTool *tool=[MTLocationTool sharedLocationTool];
    
    return [tool distanceToCurrentplaceWithlongitude:self.lng latitude:self.lat]/1000;
}

@end
