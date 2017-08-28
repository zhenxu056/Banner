//
//  MTPageControl.m
//  MTShowSocrlllView
//
//  Created by 陈振旭 on 2017/8/19.
//  Copyright © 2017年 zj-db0631. All rights reserved.
//

#import "MTPageControl.h"

@interface MTPageControl ()

@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, assign) MTPageControlPosition pagePosition;
@property (nonatomic, strong) UIView *containView;
@property(nonatomic, assign)CGFloat pageSpace;//点的间隔
@property(nonatomic, assign)MTPageControlStyle pageStyle;
@end

@implementation MTPageControl

-(instancetype)initWithFrame:(CGRect)frame
                   pageStyle:(MTPageControlStyle)pageStyle
                    position:(MTPageControlPosition)position
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _pagePosition = position;
        _pageBackgroundColor = [UIColor grayColor];
        _selectedColor = [UIColor blackColor];
        _pageSpace = 5;//默认的点的空隙
        _pageStyle = pageStyle;
        _currentPageNumber = 0;
    }
    return self;
}

-(void)setPageNumber:(NSInteger)pageNumber
{
    if (_pageNumber != pageNumber) {
        _pageNumber = pageNumber;
        
        CGFloat width = self.frame.size.width;
        CGFloat height  = self.frame.size.height;
        CGFloat totalWidth = (height + _pageSpace) *_pageNumber;
        
        _containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, totalWidth, height)];
        [self addSubview:_containView];
        
        for (NSInteger i = 0; i < _pageNumber; i++) {
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((height+_pageSpace)*i, 0, height, height)];
            switch (_pageStyle) {
                case MTPageControlStyleDefaoult:
                    imageView.layer.cornerRadius = height / 2.0;
                    imageView.layer.masksToBounds = YES;
                    break;
                case MTPageControlStyleAnimations:
                    imageView.layer.cornerRadius = height / 2.0;
                    imageView.layer.masksToBounds = YES;
                    break;
                default:
                    break;
            } 
            
            [imageView setTag:1000 + i ];
            
            imageView.backgroundColor = _pageBackgroundColor;
            
            [_containView addSubview:imageView];
        }
        
        switch (_pagePosition) {
            case MTPageControlPositionLeft:
                _containView.center = CGPointMake(0, 0);
                break;
            case MTPageControlPositionCentent:
                _containView.center = self.center;
                break;
            case MTPageControlPositionRight:
                _containView.center = CGPointMake(width - _containView.frame.size.width/2, 0);
                break;
            default:
                break;
        }
        
        UIImageView *imageView = [_containView.subviews objectAtIndex:_currentPageNumber];
        imageView.backgroundColor = _selectedColor;
    }
}
#pragma mark - 设置背景颜色方法
- (void)setPageBackgroundColor:(UIColor *)pageBackgroundColor
{
    _pageBackgroundColor = pageBackgroundColor;
    
    if (self.subviews.count != 0) {
        for (UIImageView *imageView in _containView.subviews) {
            imageView.backgroundColor = _pageBackgroundColor;
        }
        //被选中的颜色,防止被覆盖
        UIImageView *imageView = [_containView.subviews objectAtIndex:_currentPageNumber];
        imageView.backgroundColor = _selectedColor;
    }
}

#pragma mark - 被选中的颜色
- (void)setSelectedColor:(UIColor *)selectedColor
{
    if (_selectedColor != selectedColor) {
        _selectedColor = selectedColor;
        //有图的情况下
        if (self.subviews.count) {
            //修改被选中的那张图片的颜色
            UIImageView *imageView = [_containView.subviews objectAtIndex:_currentPageNumber];
            imageView.backgroundColor = _selectedColor;
        }
    }
}

#pragma mark - 设置当前被选中的下标(currentPageNumber)
- (void)setCurrentPageNumber:(NSInteger)currentPageNumber
{
    if (_currentPageNumber != currentPageNumber) {
        
        _currentPageNumber = currentPageNumber;
        //判断当前图片是否已经存在(即pageNumber是否为0)
        if (self.subviews.count) {
            //改变没有被选中的颜色
            for (UIImageView *imageView in _containView.subviews) {
                imageView.backgroundColor = _pageBackgroundColor;
            }
            UIImageView *imageView = [_containView.subviews objectAtIndex:_currentPageNumber];
            imageView.backgroundColor = _selectedColor;
            __weak typeof(self) weakSelf = self;
            if (self.frontImageView != imageView) {
                [UIView animateWithDuration:.3 animations:^{
                    weakSelf.frontImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                } completion:^(BOOL finished) {
                    if (finished) {
                        weakSelf.frontImageView = imageView;
                    }
                }];
            }
        }
    }
}

@end
