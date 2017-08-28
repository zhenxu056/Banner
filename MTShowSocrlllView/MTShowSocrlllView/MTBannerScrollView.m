//
//  MTBannerScrollView.m
//  MTShowSocrlllView
//
//  Created by 陈振旭 on 2017/8/19.
//  Copyright © 2017年 zj-db0631. All rights reserved.
//

#import "MTBannerScrollView.h"

#import "UIImageView+WebCache.h"
#import "MTPageControl.h"

#define YYMaxSections 100

NSString * const ID = @"SDCycleScrollViewCell";

@interface MTBannerScrollView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MTPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, copy) NSMutableArray *imageArray;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, assign) NSInteger currenCount;
@property (nonatomic, assign) CGSize bannerSize;

@end

@implementation MTBannerScrollView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        mainView.backgroundColor = [UIColor clearColor];
        mainView.pagingEnabled = YES;
        mainView.showsHorizontalScrollIndicator = NO;
        mainView.showsVerticalScrollIndicator = NO;
        [mainView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        
        mainView.dataSource = self;
        mainView.delegate = self;
        mainView.scrollsToTop = NO;
        _collectionView = mainView;
    }
    return _collectionView;
}

- (MTPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[MTPageControl alloc] initWithFrame:CGRectMake(0, _bannerSize.height-5, _bannerSize.width, 5) pageStyle:MTPageControlStyleAnimations position:MTPageControlPositionRight];
        _pageControl.pageNumber = _totalItemsCount;
        _pageControl.currentPageNumber = _currenCount;
        _pageControl.pageBackgroundColor = [UIColor whiteColor];
        _pageControl.selectedColor = [UIColor redColor];
    }
    return _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame
                imageURLArray:(NSArray *)urlArray
             placeholderImage:(UIImage *)placeholderImage {
    if (self = [super initWithFrame:frame]) {
        _imageArray = [[NSMutableArray alloc] initWithArray:[urlArray copy]];
        [_imageArray insertObject:[urlArray.lastObject copy] atIndex:0];
        [_imageArray insertObject:[urlArray.firstObject copy] atIndex:_imageArray.count];
        _totalItemsCount = urlArray.count;
        _placeholderImage = placeholderImage;
        _bannerSize = CGSizeMake(frame.size.width - 1, frame.size.height);
        [self setUI];
    }
    return self;
}




- (void)setUI {
    
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [self setupTimer:2.0];
    if (_totalItemsCount != 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
    
}

- (void)setTimeInterval:(CGFloat)timeInterval {
    [self setTimeInterval:timeInterval];
}

- (void)setUrlArray:(NSArray *)urlArray {
    _imageArray = [urlArray copy];
    self.pageControl.pageNumber = urlArray.count;
    _totalItemsCount = urlArray.count;
    [self.collectionView reloadData];
}

-  (void)setPlaceholderImage:(UIImage *)placeholderImage {
    [self.collectionView reloadData];
}

- (void)setupTimer:(CGFloat)time
{
    [self invalidateTimer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:time? time:2.0 target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _currenCount = 0;
}


- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)automaticScroll
{
    _currenCount ++;
    [self scrollToIndex:_currenCount];
    
    if (_currenCount == _imageArray.count-1) {
        self.pageControl.currentPageNumber = 0;
        return;
    }
    self.pageControl.currentPageNumber = _currenCount-1;
}

- (void)scrollToIndex:(NSInteger)targetIndex
{
    if (targetIndex == _imageArray.count || _totalItemsCount == 0) {
        _currenCount = 1;
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _bannerSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _bannerSize.width, _bannerSize.height)];
//    imageView.image = _imageArray[indexPath.row];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[indexPath.row]] placeholderImage:_placeholderImage];
    imageView.tag = 100 + indexPath.row;
    [cell.contentView addSubview:imageView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.bannerDelegate respondsToSelector:@selector(clickBannerViewAtIndex:)]) {
        [self.bannerDelegate clickBannerViewAtIndex:indexPath.row];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/_bannerSize.width;
    if (index == _imageArray.count - 1) {
        [self.collectionView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    }
    _currenCount = index;
}

@end
