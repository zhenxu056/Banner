//
//  MTBannerScrollView.h
//  MTShowSocrlllView
//
//  Created by 陈振旭 on 2017/8/19.
//  Copyright © 2017年 zj-db0631. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTBannerScrollViewDelegate <NSObject>

/**
 点击哪一张图
 */
-(void)clickBannerViewAtIndex:(NSInteger)index;

@end

@interface MTBannerScrollView : UIView

@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic,   copy) NSArray *urlArray;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic,   weak) id<MTBannerScrollViewDelegate>bannerDelegate;

- (instancetype)initWithFrame:(CGRect)frame
                imageURLArray:(NSArray *)urlArray
             placeholderImage:(UIImage *)placeholderImage;



@end
