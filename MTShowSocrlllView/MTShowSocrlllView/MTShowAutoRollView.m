//
//  MTShowAutoRollView.m
//  MTShowSocrlllView
//
//  Created by zj-db0631 on 2017/8/11.
//  Copyright © 2017年 zj-db0631. All rights reserved.
//

#import "MTShowAutoRollView.h"



#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define itemHeight 50

@interface MTShowAutoRollView ()

@property (nonatomic, strong) MTShowscrollView *scrollView; 

@end

@implementation MTShowAutoRollView

- (instancetype)initWithShowInView:(UIView *)view
                  theDelegate:(id<MTShowAlertViewDelegate>)delegate
                    theADInfo:(NSArray *)dataList
             placeHolderImage:(NSString *)placeHolderStr
{
    if (self = [super init]) {
        [self showAlertAnimation];
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:1.0]];
        self.scrollView = [[MTShowscrollView alloc] initWithFrame:self.bounds
                                                       ShowInView:view
                                                      theDelegate:delegate
                                                        theADInfo:dataList
                                                 placeHolderImage:placeHolderStr];
        [self addSubview:self.scrollView];
        
        [self setUI];
    }
    return self;
}

- (void)setUI {
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(ScreenWidth-15-itemHeight, ScreenHeight/10, itemHeight, itemHeight);
    [cancelButton setBackgroundColor:[UIColor redColor]];
    [cancelButton addTarget:self action:@selector(clickCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    
    UILabel *titlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/1.8, 40)];
    titlLabel.center = CGPointMake(self.center.x, ScreenHeight/6);
    titlLabel.textAlignment = NSTextAlignmentCenter;
    titlLabel.text = @"面部重塑";
    titlLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:titlLabel];
//    [titlLabel sizeToFit];
    
}

- (void)clickCancelAction:(UIButton *)sender {
    [self removeSelfFromSuperview];
}

- (void)removeSelfFromSuperview
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showAlertAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue         = [NSNumber numberWithFloat:0];
    animation.toValue           = [NSNumber numberWithFloat:1];
    animation.duration          = 0.25;
    animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:animation forKey:@"opacity"];
}
@end


@interface MTShowscrollView () <UIScrollViewDelegate> {
    CGSize size;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) CGFloat endLocation;

@property (nonatomic, copy) NSArray *showImageUrlArray;

@property (nonatomic,weak) id<MTShowAlertViewDelegate> delegate;

@property (nonatomic, copy) NSString *placeHolderImgStr;

@property (nonatomic, strong) NSMutableArray *itemButtonArray;

@end

@implementation MTShowscrollView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.backgroundColor         = [UIColor clearColor];
        _scrollView.userInteractionEnabled  = YES;
        _scrollView.contentSize     = CGSizeMake(self.frame.size.width*_showImageUrlArray.count, size.height);
        _scrollView.delegate        = self;
        _scrollView.pagingEnabled   = YES;
        _scrollView.bounces         = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *temPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        temPageControl.center = CGPointMake(self.center.x, size.height/1.3);
        temPageControl.numberOfPages  = self.showImageUrlArray.count;
        temPageControl.currentPage    = 0;
        temPageControl.pageIndicatorTintColor = [UIColor redColor];
        temPageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
        _pageControl = temPageControl;
    }
    return _pageControl;
}


- (instancetype)initWithFrame:(CGRect)frame ShowInView:(UIView *)view
                  theDelegate:(id<MTShowAlertViewDelegate>)delegate theADInfo:(NSArray *)dataList
             placeHolderImage:(NSString *)placeHolderStr
{
    if (self = [super initWithFrame:frame]) {
        size = frame.size;
        _showImageUrlArray = [dataList copy];
        self.delegate = delegate;
        self.placeHolderImgStr = placeHolderStr;
        [self layout];
    }
    return self;
}

- (void)layout {
    self.itemButtonArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 2; i ++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            itemButton.frame = CGRectMake(15, self.center.y, itemHeight, itemHeight);
        }
        else {
            itemButton.frame = CGRectMake(size.width-itemHeight-15, self.center.y, itemHeight, itemHeight);
        }
        itemButton.tag = 200 + i;
        [itemButton setBackgroundColor:[UIColor redColor]];
        
        [itemButton.layer addAnimation:[self opacityForever_Animation:1.0] forKey:nil];
        [self addSubview:itemButton];
        
        [self.itemButtonArray addObject:itemButton];
    }
    
    [self addSubview:self.scrollView];
//    [self addSubview:self.pageControl];
    
    
    
    
    for (int i = 0; i < _showImageUrlArray.count; i ++) {
        
        CGFloat offset_x   = self.frame.size.width * i;
        UIView *contreView = [[UIView alloc] initWithFrame:CGRectMake(size.width/4 + offset_x, size.height/4, size.width/2, size.height/2)];
        contreView.tag     = 100 + i;
        [self.scrollView addSubview:contreView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:contreView.bounds];
        
        imageView.image = [UIImage imageNamed:self.placeHolderImgStr];
        imageView.image = _showImageUrlArray[i];
        [contreView addSubview:imageView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentImgView:)];
        [contreView addGestureRecognizer:singleTap];
    }
    
    [self hiddenLeftOrRightItem];
}

-(void)tapContentImgView:(UITapGestureRecognizer *)gesture{
    UIView *imageView = gesture.view;
    NSInteger itemTag = (long)imageView.tag-100;
    if ([self.delegate respondsToSelector:@selector(clickAlertViewAtIndex:)]) {
        [self.delegate clickAlertViewAtIndex:itemTag];
    }
}


#pragma mark - UIScrollViewDelegate

 - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     NSInteger index = scrollView.contentOffset.x/ScreenWidth;
     self.pageControl.currentPage = index;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pauseAnimation];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self starAnimation];
    [self hiddenLeftOrRightItem];
}

#pragma mark - Private Method

- (void)hiddenLeftOrRightItem {
    UIButton *leftButton  = self.itemButtonArray[0];
    UIButton *rightButton = self.itemButtonArray[1];
    
    if (self.pageControl.currentPage == self.showImageUrlArray.count-1) {
        rightButton.hidden = YES;
        leftButton.hidden  = NO;
    }
    else if (self.pageControl.currentPage == 0) {
        rightButton.hidden = NO;
        leftButton.hidden  = YES;
    }
    else {
        rightButton.hidden = NO;
        leftButton.hidden  = NO;
    }
}

- (void)pauseAnimation{
    for (UIButton *button in self.itemButtonArray) {
        // 将当前时间CACurrentMediaTime转换为layer上的时间, 即将parent time转换为local time
        CFTimeInterval pauseTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        
        // 设置layer的timeOffset, 在继续操作也会使用到
        button.layer.timeOffset = pauseTime;
        
        // local time与parent time的比例为0, 意味着local time暂停了
        button.layer.speed = 0;
    }
}

- (void)starAnimation {
    for (UIButton *button in self.itemButtonArray) {
        // 时间转换
        CFTimeInterval pauseTime = button.layer.timeOffset;
        // 计算暂停时间
        CFTimeInterval timeSincePause = CACurrentMediaTime() - pauseTime;
        // 取消
        button.layer.timeOffset = 0;
        // local time相对于parent time世界的beginTime
        button.layer.beginTime = timeSincePause;
        // 继续
        button.layer.speed = 1;
    }
}

#pragma mark - Animation
#pragma mark -- 永久闪烁的动画
-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

@end
