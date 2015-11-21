//
//  UIImage+Extension.m
//  网易新闻
//
//  Created by 郑雨鑫 on 15/11/3.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+(UIImage *)imageWithColor:(UIColor *)color
{
    CGFloat imageH=100;
    CGFloat imageW=100;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0);
    
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageW));
    
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;

}

@end
