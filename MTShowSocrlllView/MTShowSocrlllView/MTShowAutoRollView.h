//
//  MTShowAutoRollView.h
//  MTShowSocrlllView
//
//  Created by zj-db0631 on 2017/8/11.
//  Copyright © 2017年 zj-db0631. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTShowScorllView;

@protocol MTShowAlertViewDelegate <NSObject>

/**
 点击哪一张图
 */
-(void)clickAlertViewAtIndex:(NSInteger)index;

@end

@interface MTShowAutoRollView : UIView

- (instancetype)initWithShowInView:(UIView *)view
                       theDelegate:(id<MTShowAlertViewDelegate>)delegate
                         theADInfo:(NSArray *)dataList
                  placeHolderImage:(NSString *)placeHolderStr;

@end


/**
 滚动视图
 */
@interface MTShowscrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                   ShowInView:(UIView *)view
                  theDelegate:(id<MTShowAlertViewDelegate>)delegate
                    theADInfo:(NSArray *)dataList
             placeHolderImage:(NSString *)placeHolderStr;

@end
