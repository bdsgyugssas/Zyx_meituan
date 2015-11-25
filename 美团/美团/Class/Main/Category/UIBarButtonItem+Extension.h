//
//  UIBarButtonItem+Extension.h
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithimage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)targrt action:(SEL)action;
+ (UIBarButtonItem *)itemWithimage:(NSString *)image highlightedImage:(NSString *)highlightedImage;
@end
