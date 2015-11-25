
//
//  MTMerchantChoseView.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/24.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTMerchantChoseView.h"
#import "MTMerchantButton.h"

@interface MTMerchantChoseView ()

@property (strong, nonatomic) NSMutableArray *allButton;

@property (strong, nonatomic) NSMutableArray *allLine;

@end

@implementation MTMerchantChoseView
#pragma mark -懒加载
- (NSMutableArray *)allButton
{
    if (_allButton==nil) {
        _allButton=[NSMutableArray array];
    }
    return _allButton;

}

- (NSMutableArray *)allLine
{
    if (_allLine==nil) {
        _allLine=[NSMutableArray array];
    }
    return _allLine;
    
}


+ (MTMerchantChoseView *)merchantChoseView
{
    return [[self alloc]init];

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
   
        [self buttonWithTitle:@"全部" type:MTMerchantButtonAll];
        [self buttonWithTitle:@"全城" type:MTMerchantButtonAllCity];
        [self buttonWithTitle:@"智能排序" type:MTMerchantButtonIntelligence];
        
        [self addDividingLine];
        [self addDividingLine];
       
    }
    return self;
    
}

- (void)buttonWithTitle:(NSString *)title type:(MTMerchantButtonType)type
{
    MTMerchantButton *button=[[MTMerchantButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag=type;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.allButton addObject:button];
}

- (void)addDividingLine
{
    UIImageView *dividingLineView=[[UIImageView alloc]init];
    dividingLineView.image=[UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:dividingLineView];
    [self.allLine addObject:dividingLineView];
    

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger countOfButton=self.allButton.count;
    
    CGFloat btnW=self.width/countOfButton;
    CGFloat btnH=self.height;
    for (int i=0; i<countOfButton; i++) {
        UIButton *button=self.allButton[i];
        button.width=btnW;
        button.height=btnH;
        button.x=i*btnW;
        button.y=0;
    }
    
    NSInteger countOfLine=self.allLine.count;
    
    CGFloat lineW=1;
    CGFloat lineH=self.height;
    for (int i=0; i<countOfLine; i++) {
        UIImageView *lineView=self.allLine[i];
        lineView.width=lineW;
        lineView.height=lineH;
        lineView.x=(i+1)*btnW;
        lineView.y=0;
    }
    
    
    

}


- (void)buttonClick:(MTMerchantButton *)button
{
    if (button==self.selectedButton) {
        button.selected=!button.isSelected;
    }else{
        self.selectedButton.selected=NO;
        button.selected=YES;
        self.selectedButton=button;
    }
    



}
@end
