//
//  ViewController.m
//  ScrollViewPage
//
//  Created by CYY033 on 16/4/27.
//  Copyright © 2016年 LYC. All rights reserved.
//

#import "ViewController.h"
#import "TitleView.h"
@interface ViewController ()
@property (nonatomic, strong) TitleView *titleBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _titleBar = [[TitleView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40) andTitles:@[@"红",@"绿",@"蓝"]];
    [self.view addSubview:_titleBar];
    
    UIScrollView  *ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleBar.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(_titleBar.frame))];
    
    for (int i = 0;i < 3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i, 0, ScrollView.bounds.size.height, ScrollView.bounds.size.height)];
        view.backgroundColor = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]][i];
        [ScrollView addSubview:view];
    }
    ScrollView.pagingEnabled = YES;
    ScrollView.delegate      = self;
    ScrollView.contentSize = CGSizeMake(ScrollView.bounds.size.width * 3, ScrollView.bounds.size.height);
    [self.view addSubview:ScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat horizonalOffset =   scrollView.contentOffset.x;
    CGFloat screenWidth = scrollView.frame.size.width;
    CGFloat offsetRatio = (NSUInteger)horizonalOffset % (NSUInteger)screenWidth / screenWidth;
    NSUInteger focusIndex = (horizonalOffset + screenWidth / 2) / screenWidth;
    
    if (horizonalOffset != focusIndex * screenWidth) {
        NSUInteger animationIndex = horizonalOffset > focusIndex * screenWidth ? focusIndex + 1: focusIndex - 1;
        if (focusIndex > animationIndex) {offsetRatio = 1 - offsetRatio;}
        if (scrollView) {
            [self scrolloffsetRatio:offsetRatio focusIndex:focusIndex animationIndex:animationIndex];
        }
    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat horizonalOffset =   scrollView.contentOffset.x;
    CGFloat screenWidth = scrollView.frame.size.width;
    CGFloat offsetRatio = (NSUInteger)horizonalOffset % (NSUInteger)screenWidth / screenWidth;
    NSUInteger focusIndex = (horizonalOffset + screenWidth / 2) / screenWidth;
    
    if (horizonalOffset != focusIndex * screenWidth) {
        NSUInteger animationIndex = horizonalOffset > focusIndex * screenWidth ? focusIndex + 1: focusIndex - 1;
        if (focusIndex > animationIndex) {offsetRatio = 1 - offsetRatio;}
        if (scrollView) {
            [self scrolloffsetRatio:offsetRatio focusIndex:focusIndex animationIndex:animationIndex];
        }
    }
    
    _titleBar.currentIndex = focusIndex;
    for (UIButton *button in _titleBar.titleButtons) {
        if (button.tag != focusIndex) {
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            button.transform = CGAffineTransformIdentity;
        } else {
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            button.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }
    }


}


- (void)scrolloffsetRatio:(CGFloat)offsetRatio
               focusIndex:(NSUInteger )focusIndex
           animationIndex:(NSUInteger)animationIndex{
    
    
    UIButton *titleFrom = _titleBar.titleButtons[animationIndex];
    UIButton *titleTo = _titleBar.titleButtons[focusIndex];
    CGFloat colorValue = (CGFloat)0x90 / (CGFloat)0xFF;
    
    [UIView transitionWithView:titleFrom duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [titleFrom setTitleColor:[UIColor colorWithRed:colorValue*(1-offsetRatio) green:colorValue blue:colorValue*(1-offsetRatio) alpha:1.0]
                        forState:UIControlStateNormal];
        titleFrom.transform = CGAffineTransformMakeScale(1 + 0.2 * offsetRatio, 1 + 0.2 * offsetRatio);
    } completion:nil];
    
    
    [UIView transitionWithView:titleTo duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [titleTo setTitleColor:[UIColor colorWithRed:colorValue*offsetRatio green:colorValue blue:colorValue*offsetRatio alpha:1.0]
                      forState:UIControlStateNormal];
        titleTo.transform = CGAffineTransformMakeScale(1 + 0.2 * (1-offsetRatio), 1 + 0.2 * (1-offsetRatio));
    } completion:nil];

}
@end
