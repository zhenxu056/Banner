//
//  ViewController.m
//  MTShowSocrlllView
//
//  Created by zj-db0631 on 2017/8/11.
//  Copyright © 2017年 zj-db0631. All rights reserved.
//

#import "ViewController.h"

#import "MTShowAutoRollView.h"

#import "MTPageControl.h"

#import "MTBannerScrollView.h"

@interface ViewController ()<MTShowAlertViewDelegate,MTBannerScrollViewDelegate, UIScrollViewDelegate> {
    MTPageControl *page;
    MTBannerScrollView *banner;
}

@end

@implementation ViewController
- (IBAction)buttonAciton:(id)sender {
    NSArray *imgaeArr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"5.jpg",@"5.jpg",@"5.jpg",@"5.jpg",@"5.jpg",@"5.jpg",@"5.jpg",@"5.jpg",@"5.jpg",@"5.jpg",@"5.jpg"];
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < imgaeArr.count; i ++) {
        [imageArray addObject:[UIImage imageNamed:imgaeArr[i]]];
    }
    
    
//    MTShowAutoRollView *view = [[MTShowAutoRollView alloc] initWithShowInView:nil theDelegate:self theADInfo:imageArray placeHolderImage:@""];
//    [[[UIApplication sharedApplication].windows objectAtIndex:0] endEditing:YES];
//    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:view];
    
//    [self.view addSubview:view];
    NSArray *urlarray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503142848010&di=2068bfb8961198c38cfe9fae7dfe9ab8&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201602%2F18%2F20160218023812_J4uUZ.thumb.700_0.jpeg",@"",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503142848010&di=bd9bc13cc6acd858331f7a6fa2d9ae4a&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201501%2F05%2F20150105213321_2wLt2.jpeg",@"",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503142848009&di=f0da91d12458891048bd5ebc3ae81126&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201501%2F09%2F20150109234503_Vnv3X.jpeg"];
    banner.urlArray = urlarray;
    
    banner.placeholderImage = [UIImage imageNamed:@"2.jpg"];
}

- (void)clickAlertViewAtIndex:(NSInteger)index {
    NSLog(@"clickImage: %ld",index);
}
- (void)clickBannerViewAtIndex:(NSInteger)index {
    NSLog(@"clickImage: %ld",index);
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self runAnimateKeyframes];
    
//    page = [[MTPageControl alloc] initWithFrame:CGRectMake(0, 100, 200, 10) pageStyle:MTPageControlStyleAnimations];
//    
//    page.selectedColor = [UIColor blackColor];
//    page.pageBackgroundColor = [UIColor brownColor];
//    page.pageNumber = 7;
//    page.currentPageNumber = 0;
//    
//    
//    [self.view addSubview:page];
    
    
    NSArray *imgaeArr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg"];
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < imgaeArr.count; i ++) {
        [imageArray addObject:[UIImage imageNamed:imgaeArr[i]]];
    }
    NSArray *urlarray = @[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3677525115,1058358086&fm=26&gp=0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503314617703&di=1291f807b07bd7411ce98f987d81a231&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D494821ec88025aafc73f76889384c111%2Fa50f4bfbfbedab649b142aecfd36afc379311eb3.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503314633241&di=9105bc723fb5bdec2cabc23567588f10&imgtype=0&src=http%3A%2F%2Fm.qqzhi.com%2Fupload%2Fimg_1_1363102056D3513263465_23.jpg"];
    banner = [[MTBannerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) imageURLArray:urlarray placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    banner.bannerDelegate = self;
    
    [self.view addSubview:banner];
    
}

- (void)runAnimateKeyframes {
    
    /**
     *  relativeDuration  动画在什么时候开始
     *  relativeStartTime 动画所持续的时间
     */
    
    [UIView animateKeyframesWithDuration:6.f
                                   delay:5.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0   // 相对于6秒所开始的时间（第0秒开始动画）
                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                                                animations:^{
                                                                    self.view.backgroundColor = [UIColor redColor];
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:1/3.0 // 相对于6秒所开始的时间（第2秒开始动画）
                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                                                animations:^{
                                                                    self.view.backgroundColor = [UIColor yellowColor];
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:2/3.0 // 相对于6秒所开始的时间（第4秒开始动画）
                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                                                animations:^{
                                                                    self.view.backgroundColor = [UIColor greenColor];                                                                }];
                                  
                              }
                              completion:^(BOOL finished) {
                                  [self runAnimateKeyframes];
                              }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint pint = scrollView.contentOffset;
    NSLog(@"offect %lf",pint.y);
    NSLog(@"%lf %lf",pint.y/522, (self.view.frame.size.height-150-64 ));
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:pint.y/self.view.frame.size.height];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
