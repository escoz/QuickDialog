//
//  YRDropdownViewIMS.m
//  YRDropdownViewExample
//
//  Created by Eli Perkins on 1/27/12.
//  Copyright (c) 2012 One Mighty Roar. All rights reserved.
//

#import "YRDropdownViewIMS.h"
#import <QuartzCore/QuartzCore.h>

@interface UILabel (YRDropdownViewIMS)
- (void)sizeToFitFixedWidth:(CGFloat)fixedWidth;
@end

@implementation UILabel (YRDropdownViewIMS)


- (void)sizeToFitFixedWidth:(CGFloat)fixedWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, 0);
    self.lineBreakMode = UILineBreakModeWordWrap;
    self.numberOfLines = 0;
    [self sizeToFit];
}
@end

@interface YRDropdownViewIMS ()
- (void)updateTitleLabel:(NSString *)newText;
- (void)updateDetailLabel:(NSString *)newText;
- (void)hideUsingAnimation:(NSNumber *)animated;
- (void)done;
@end


@implementation YRDropdownViewIMS
@synthesize titleText;
@synthesize detailText;
@synthesize minHeight;
@synthesize backgroundImage;
@synthesize accessoryImage;
@synthesize onTouch;
@synthesize shouldAnimate;

UIView *theView;

//Using this prevents two alerts to ever appear on the screen at the same time
//TODO: Queue alerts, if multiple
static YRDropdownViewIMS *currentDropdown = nil;

+ (YRDropdownViewIMS *)currentDropdownView
{
    return currentDropdown;
}

#pragma mark - Accessors

- (NSString *)titleText
{
    return titleText;
}

- (void)setTitleText:(NSString *)newText
{
    if ([NSThread isMainThread]) {
		[self updateTitleLabel:newText];
		[self setNeedsLayout];
		[self setNeedsDisplay];
	} else {
		[self performSelectorOnMainThread:@selector(updateTitleLabel:) withObject:newText waitUntilDone:NO];
		[self performSelectorOnMainThread:@selector(setNeedsLayout) withObject:nil waitUntilDone:NO];
		[self performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:NO];
	}
}

- (NSString *)detailText
{
    return detailText;
}

- (void)setDetailText:(NSString *)newText
{
    if ([NSThread isMainThread]) {
        [self updateDetailLabel:newText];
        [self setNeedsLayout];
        [self setNeedsDisplay];
    } else {
        [self performSelectorOnMainThread:@selector(updateDetailLabel:) withObject:newText waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(setNeedsLayout) withObject:nil waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:NO];
    }
}

- (void)updateTitleLabel:(NSString *)newText {
    if (titleText != newText) {
#if !__has_feature(objc_arc)
        [titleText release];
#endif
        titleText = [newText copy];
        titleLabel.text = titleText;
    }
}

- (void)updateDetailLabel:(NSString *)newText {
    if (detailText != newText) {
#if !__has_feature(objc_arc)
        [detailText release];
#endif
        detailText = [newText copy];
        detailLabel.text = detailText;
    }
}



#pragma mark - Initializers
- (id)init
{
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 768.0f, 44.0f)];
}

- (id)initWithFrame:(CGRect)frame type:(NSInteger)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleText = nil;
        self.detailText = nil;
        self.minHeight = 44.0f;
        if (type == YRWarning)
        {
            self.backgroundImage = [UIImage imageNamed:@"bg-orange.png"];
        }
        else if (type == YRError)
        {
            self.backgroundImage = [UIImage imageNamed:@"bg-red.png"];
        }
        else
        {
            self.backgroundImage = [UIImage imageNamed:@"bg-blue.png"];
        }
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        detailLabel = [[UILabel alloc] initWithFrame:self.bounds];
        backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroundImageView.image = [self.backgroundImage stretchableImageWithLeftCapWidth:1 topCapHeight:self.backgroundImage.size.height/2];
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        accessoryImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:backgroundImageView];
        
        self.opaque = YES;
        
        onTouch = @selector(hide:);
    }
    return self;
}

#pragma mark - Defines

#define HORIZONTAL_PADDING 15.0f
#define VERTICAL_PADDING 19.0f
#define IMAGE_PADDING 45.0f
#define TITLE_FONT_SIZE 19.0f
#define DETAIL_FONT_SIZE 16.0f
#define ANIMATION_DURATION 0.3f

#pragma mark - Class methods
#pragma mark View Methods
+ (YRDropdownViewIMS *)showDropdownInView:(UIView *)view type:(NSInteger)type title:(NSString *)title
{
    return [YRDropdownViewIMS showDropdownInView:view type:type title:title detail:nil];
}

+ (YRDropdownViewIMS *)showDropdownInView:(UIView *)view type:(NSInteger)type title:(NSString *)title detail:(NSString *)detail
{
    return [YRDropdownViewIMS showDropdownInView:view type:type title:title detail:detail image:nil animated:YES];
}

+ (YRDropdownViewIMS *)showDropdownInView:(UIView *)view type:(NSInteger)type title:(NSString *)title detail:(NSString *)detail animated:(BOOL)animated
{
    return [YRDropdownViewIMS showDropdownInView:view type:type title:title detail:detail image:nil animated:animated hideAfter:0.0];
}

+ (YRDropdownViewIMS *)showDropdownInView:(UIView *)view type:(NSInteger)type title:(NSString *)title detail:(NSString *)detail image:(UIImage *)image animated:(BOOL)animated
{
    return [YRDropdownViewIMS showDropdownInView:view type:type title:title detail:detail image:image animated:animated hideAfter:0.0];
}

+ (YRDropdownViewIMS *)showDropdownInView:(UIView *)view 
                                  type:(NSInteger)type
                                 title:(NSString *)title 
                                detail:(NSString *)detail 
                                 image:(UIImage *)image
                              animated:(BOOL)animated
                             hideAfter:(float)delay
{
    if (currentDropdown) {
        [currentDropdown hideUsingAnimation:[NSNumber numberWithBool:animated]];
    }
    theView = view;
    view.hidden = NO;
    YRDropdownViewIMS *dropdown = [[YRDropdownViewIMS alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 44) type:type];
    
    currentDropdown = dropdown;
    dropdown.titleText = title;
    
    if (detail) {
        dropdown.detailText = detail;
    } 
    
    if (image) {
        dropdown.accessoryImage = image;
    }
    
    dropdown.shouldAnimate = animated;
    
    if ([view isKindOfClass:[UIWindow class]]) {
        CGRect dropdownFrame = dropdown.frame;
        CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
        dropdownFrame.origin.y = appFrame.origin.y;
        dropdown.frame = dropdownFrame;
    }
    
    [view addSubview:dropdown];
    [dropdown show:animated];
    if (delay != 0.0) {
        [dropdown performSelector:@selector(hideUsingAnimation:) withObject:[NSNumber numberWithBool:animated] afterDelay:delay+ANIMATION_DURATION];
    }
    
    return dropdown;
}

+ (void)removeView 
{
    if (!currentDropdown) {
        return;
    }
    
    [currentDropdown removeFromSuperview];
    
    [currentDropdown release];
    currentDropdown = nil;
}

+ (BOOL)hideDropdownInView:(UIView *)view
{
    return [YRDropdownViewIMS hideDropdownInView:view animated:YES];
}

+ (BOOL)hideDropdownInView:(UIView *)view animated:(BOOL)animated
{
    if (currentDropdown) {
        [currentDropdown hideUsingAnimation:[NSNumber numberWithBool:animated]];
        return YES;
    }
    
    UIView *viewToRemove = nil;
    for (UIView *v in [view subviews]) {
        if ([v isKindOfClass:[YRDropdownViewIMS class]]) {
            viewToRemove = v;
        }
    }
    if (viewToRemove != nil) {
        YRDropdownViewIMS *dropdown = (YRDropdownViewIMS *)viewToRemove;
        [dropdown hideUsingAnimation:[NSNumber numberWithBool:animated]];
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - Methods

- (void)show:(BOOL)animated
{
    if(animated)
    {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-self.frame.size.height, self.frame.size.width, self.frame.size.height);
        self.alpha = 0.02;
        [UIView animateWithDuration:ANIMATION_DURATION
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.alpha = 1.0;
                             self.frame = CGRectMake(self.frame.origin.x, 
                                                     self.frame.origin.y+self.frame.size.height,
                                                     self.frame.size.width, self.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             if (finished)
                             {
                                 
                             }
                         }];
        
    }
}

- (void)hide:(BOOL)animated
{
    [self done];
    theView.hidden = YES;
}

- (void)hideUsingAnimation:(NSNumber *)animated {
    if ([animated boolValue]) {
        [UIView animateWithDuration:ANIMATION_DURATION
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.alpha = 0.02;
                             self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-self.frame.size.height, self.frame.size.width, self.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             if (finished)
                             {
                                 [self done];
                             }
                         }];        
    }
    else {
        self.alpha = 0.0f;
        [self done];
    }
}

- (void)done
{
    [self removeFromSuperview];
    //theView.hidden = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideUsingAnimation:[NSNumber numberWithBool:self.shouldAnimate]];
}

#pragma mark - Layout

- (void)layoutSubviews {    
    // Set label properties
    titleLabel.font = [UIFont boldSystemFontOfSize:TITLE_FONT_SIZE];
    titleLabel.adjustsFontSizeToFitWidth = NO;
    titleLabel.opaque = NO;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor]; //colorWithWhite:0.225 alpha:1.0];
    titleLabel.shadowOffset = CGSizeMake(0, 1/[[UIScreen mainScreen] scale]);
    titleLabel.shadowColor = [UIColor colorWithWhite:1 alpha:0.25];
    titleLabel.text = self.titleText;
    [titleLabel sizeToFitFixedWidth:self.bounds.size.width - (2 * HORIZONTAL_PADDING)];
    
    titleLabel.frame = CGRectMake(self.bounds.origin.x + HORIZONTAL_PADDING, 
                                  self.bounds.origin.y + VERTICAL_PADDING - 8, 
                                  self.bounds.size.width - (2 * HORIZONTAL_PADDING), 
                                  titleLabel.frame.size.height);
    
    [self addSubview:titleLabel];
    
    if (self.detailText) {
        detailLabel.font = [UIFont systemFontOfSize:DETAIL_FONT_SIZE];
        detailLabel.numberOfLines = 0;
        detailLabel.adjustsFontSizeToFitWidth = NO;
        detailLabel.opaque = NO;
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textColor = [UIColor colorWithWhite:0.225 alpha:1.0];
        detailLabel.textColor = [UIColor whiteColor]; //colorWithWhite:0.225 alpha:1.0];
        detailLabel.shadowOffset = CGSizeMake(0, 1/[[UIScreen mainScreen] scale]);
        detailLabel.shadowColor = [UIColor colorWithWhite:1 alpha:0.25];
        detailLabel.text = self.detailText;
        [detailLabel sizeToFitFixedWidth:self.bounds.size.width - (2 * HORIZONTAL_PADDING)];
        
        detailLabel.frame = CGRectMake(self.bounds.origin.x + HORIZONTAL_PADDING, 
                                       titleLabel.frame.origin.y + titleLabel.frame.size.height + 2, 
                                       self.bounds.size.width - (2 * HORIZONTAL_PADDING), 
                                       detailLabel.frame.size.height);
        
        [self addSubview:detailLabel];
    } else {
        titleLabel.frame = CGRectMake(titleLabel.frame.origin.x,
                                      9,
                                      titleLabel.frame.size.width, 
                                      titleLabel.frame.size.height);
    }
    
    if (self.accessoryImage) {
        accessoryImageView.image = self.accessoryImage;
        accessoryImageView.frame = CGRectMake(self.bounds.origin.x + HORIZONTAL_PADDING, 
                                              self.bounds.origin.y + VERTICAL_PADDING,
                                              self.accessoryImage.size.width,
                                              self.accessoryImage.size.height);
        
        [titleLabel sizeToFitFixedWidth:self.bounds.size.width - IMAGE_PADDING - (HORIZONTAL_PADDING * 2)];
        titleLabel.frame = CGRectMake(titleLabel.frame.origin.x + IMAGE_PADDING, 
                                      titleLabel.frame.origin.y, 
                                      titleLabel.frame.size.width, 
                                      titleLabel.frame.size.height);
        
        if (self.detailText) {
            [detailLabel sizeToFitFixedWidth:self.bounds.size.width - IMAGE_PADDING - (HORIZONTAL_PADDING * 2)];
            detailLabel.frame = CGRectMake(detailLabel.frame.origin.x + IMAGE_PADDING, 
                                           detailLabel.frame.origin.y, 
                                           detailLabel.frame.size.width, 
                                           detailLabel.frame.size.height);
        }
        
        [self addSubview:accessoryImageView];
    }
    
    CGFloat dropdownHeight = 44.0f;
    if (self.detailText) {
        dropdownHeight = MAX(CGRectGetMaxY(self.bounds), CGRectGetMaxY(detailLabel.frame));
        dropdownHeight += VERTICAL_PADDING;
    } 
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, dropdownHeight)];
    
    [backgroundImageView setFrame:self.bounds];
    
}

@end


