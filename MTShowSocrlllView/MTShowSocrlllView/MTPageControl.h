//
//  MTPageControl.h
//  MTShowSocrlllView
//
//  Created by 陈振旭 on 2017/8/19.
//  Copyright © 2017年 zj-db0631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTPageControl : UIView

typedef enum : NSInteger {
    MTPageControlStyleDefaoult = 0,/* 系统 */
    MTPageControlStyleAnimations /** 选中动画 */
} MTPageControlStyle;

typedef enum : NSInteger {
    MTPageControlPositionLeft = 0,
    MTPageControlPositionCentent,
    MTPageControlPositionRight
} MTPageControlPosition;

@property(nonatomic, assign)NSInteger pageNumber;//点的个数
@property(nonatomic, strong)UIColor *pageBackgroundColor;//点的背景颜色
@property(nonatomic, strong)UIColor *selectedColor;//选中的背景色
@property(nonatomic, assign)NSInteger currentPageNumber;//当前点击的pageNumber

-(instancetype)initWithFrame:(CGRect)frame
                   pageStyle:(MTPageControlStyle)pageStyle
                    position:(MTPageControlPosition)position;

@end
