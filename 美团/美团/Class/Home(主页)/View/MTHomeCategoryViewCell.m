//
//  MTHomeCategoryViewCell.m
//  美团
//
//  Created by 郑雨鑫 on 15/11/22.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MTHomeCategoryViewCell.h"
#import "MTOnePageCategoryView.h"

#define  CellH 150

@interface MTHomeCategoryViewCell () <UIScrollViewDelegate>
/**
 *  滚动视图
 */
@property (weak, nonatomic) UIScrollView *scrollView;
/**
 *  页码
 */
@property (weak, nonatomic) UIPageControl *pageControl;
@end

@implementation MTHomeCategoryViewCell

+ (MTHomeCategoryViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *cell1=@"Catrgory";
    MTHomeCategoryViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cell1];
    if (cell==nil) {
        cell=[[MTHomeCategoryViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
    }
    return cell;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIScrollView *scrollView=[[UIScrollView alloc]init];
        [self addSubview:scrollView];
        scrollView.bounces=NO;
        scrollView.showsHorizontalScrollIndicator=NO;
        scrollView.showsVerticalScrollIndicator=NO;
        scrollView.backgroundColor=[UIColor whiteColor];
        scrollView.delegate=self;
        self.scrollView=scrollView;
        
        MTOnePageCategoryView *pageOne=[[MTOnePageCategoryView alloc]init];
        [self.scrollView addSubview:pageOne];
        
        MTOnePageCategoryView *pageTwo=[[MTOnePageCategoryView alloc]init];
        [self.scrollView addSubview:pageTwo];

        UIPageControl *pageControl=[[UIPageControl alloc]init];
        [self addSubview:pageControl];
        pageControl.userInteractionEnabled=NO;
        pageControl.numberOfPages=2;
        pageControl.currentPageIndicatorTintColor=RGB(40, 180, 156);
        pageControl.pageIndicatorTintColor=RGB(111, 111, 111);
        self.pageControl=pageControl;
        
        
        
    }
    return self;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage= (int) ((double)scrollView.contentOffset.x/ScreenW+0.5);

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame=CGRectMake(0, 0, ScreenW, CellH-10);
    
    self.pageControl.width=100;
    self.pageControl.height=10;
    self.pageControl.centerX=self.centerX;
    self.pageControl.y=self.height-15;
    
    for (int i=0; i<2; i++) {
        MTOnePageCategoryView *pageView=self.scrollView.subviews[i];
        pageView.width=ScreenW;
        pageView.height=CellH-10;
        pageView.x=i*ScreenW;
        pageView.y=0;
    }
    
    self.scrollView.contentSize=CGSizeMake(2*ScreenW, 0);

}



@end
