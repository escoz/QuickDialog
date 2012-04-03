//
//  YRDropdownViewIMS.h
//  YRDropdownViewExample
//
//  Created by Eli Perkins on 1/27/12.
//  Copyright (c) 2012 One Mighty Roar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

enum
{
    YRWarning,
    YRError,
    YRHelp
};

@interface YRDropdownViewIMS : UIView
{
    NSString *titleText;
    NSString *detailText;
    UILabel *titleLabel;
    UILabel *detailLabel;
    UIImage *backgroundImage;
    UIImageView *backgroundImageView;
    UIImage *accessoryImage;
    UIImageView *accessoryImageView;
    SEL onTouch;
    NSDate *showStarted;
    BOOL shouldAnimate;
}

@property (copy) NSString *titleText;
@property (copy) NSString *detailText;
@property (assign) UIImage *accessoryImage;
@property (assign) float minHeight;
@property (nonatomic, assign) UIImage *backgroundImage;
@property (nonatomic, assign) SEL onTouch;
@property (assign) BOOL shouldAnimate;

#pragma mark - View methods

+ (YRDropdownViewIMS *)showDropdownInView:(UIView *)view
                                  type:(NSInteger)type
                                 title:(NSString *)title;

+ (YRDropdownViewIMS *)showDropdownInView:(UIView *)view
                                  type:(NSInteger)type
                                 title:(NSString *)title
                                detail:(NSString *)detail;

+ (YRDropdownViewIMS *)showDropdownInView:(UIView *)view
                                  type:(NSInteger)type
                                 title:(NSString *)title
                                detail:(NSString *)detail
                              animated:(BOOL)animated;

+ (YRDropdownViewIMS *)showDropdownInView:(UIView *)view
                                  type:(NSInteger)type
                                 title:(NSString *)title
                                detail:(NSString *)detail
                                 image:(UIImage *)image
                              animated:(BOOL)animated;

+ (YRDropdownViewIMS *)showDropdownInView:(UIView *)view
                                  type:(NSInteger)type
                                 title:(NSString *)title
                                detail:(NSString *)detail
                                 image:(UIImage *)image
                              animated:(BOOL)animated
                             hideAfter:(float)delay;

+ (BOOL)hideDropdownInView:(UIView *)view;
+ (BOOL)hideDropdownInView:(UIView *)view animated:(BOOL)animated;

#pragma mark -
- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;

@end

