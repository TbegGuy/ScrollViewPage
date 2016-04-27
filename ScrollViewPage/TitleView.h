//
//  TitleView.h
//  ScrollViewPage
//
//  Created by CYY033 on 16/4/27.
//  Copyright © 2016年 LYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleView : UIScrollView
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, copy) void (^titleButtonClicked)(NSUInteger index);

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray*)titles;

- (void)setTitleButtonsColor;

@end
