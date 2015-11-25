//
//  UIBarButtonItem+Extension.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/21.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


+ (UIBarButtonItem *)itemWithimage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)targrt action:(SEL)action
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    button.size=CGSizeMake(25, 25);
    [button addTarget:targrt action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;

}

+ (UIBarButtonItem *)itemWithimage:(NSString *)image highlightedImage:(NSString *)highlightedImage
{
     return [self itemWithimage:image highlightedImage:highlightedImage target:nil action:nil];
}
@end
