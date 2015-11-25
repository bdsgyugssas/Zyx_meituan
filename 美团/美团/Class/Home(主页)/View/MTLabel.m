//
//  MTLabel.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/25.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTLabel.h"

@implementation MTLabel

- (void)setStrikethrough:(BOOL)strikethrough
{
    _strikethrough=strikethrough;
    

    if (strikethrough==YES) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        dict[NSStrikethroughStyleAttributeName]=[NSNumber numberWithInteger:NSUnderlineStyleSingle];

        NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:self.text attributes:dict];
        self.attributedText=str;
    }

}


@end
