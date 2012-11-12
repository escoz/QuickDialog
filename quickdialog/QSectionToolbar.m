//
//  QSectionToolbar.m
//  QuickDialog
//
//  Created by Michael Kunz on 09.11.12.
//
//

#import "QSectionToolbar.h"
#import <objc/runtime.h>
#import <objc/message.h>


static UIImage * clearImage;
static UIBarButtonItem * fixedSpace;

@implementation QSectionToolbarItem

@synthesize section = _section;
@synthesize systemItem = _systemItem;
@synthesize controllerAction = _controllerAction;
@synthesize enabled = _enabled;
@synthesize image = _image;
@synthesize imageNamed = _imageNamed;
@synthesize title = _title;

- (id) init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    _systemItem = -1;
    _enabled = YES;
    
    return self;
}

- (void) setImageNamed:(NSString *)imageNamed
{
    _imageNamed = imageNamed;
    _image = [UIImage imageNamed:imageNamed];
}

@end

@implementation QSectionToolbar
{
    QuickDialogController * _controller;
    NSArray * _items;
}

+ (void) load
{
    clearImage = [UIImage new];
    fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    fixedSpace.width = 7;
}

- (void) setFrame:(CGRect)frame
{
    frame.origin.y += 3;
    [super setFrame:frame];
}

- (void) onAction:(id)sender
{
    NSUInteger index = [sender tag];
    if (index >= _items.count)
        return;
    QSectionToolbarItem * item = [_items objectAtIndex:index];
    SEL action = NSSelectorFromString(item.controllerAction);
    if (action)
        objc_msgSend(_controller, action, item);
}

- (QSectionToolbar*) initWithElements: (NSArray*)elements controller:(QuickDialogController*)controller
{
    self = [super initWithFrame:CGRectNull];
    if (self == nil)
        return nil;
 
    _items = elements;
    _controller = controller;
    
    // make transparent
    [self setBackgroundImage:clearImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [self setShadowImage:clearImage forToolbarPosition:UIToolbarPositionAny];
    
    NSUInteger index = 0;
    NSMutableArray * res = [NSMutableArray arrayWithCapacity:elements.count+2];
    [res addObject:fixedSpace];
    for (QSectionToolbarItem* i in elements)
    {
        UIBarButtonItem * item = nil;
        
        if (i.systemItem >= 0)
        {
            item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:i.systemItem target:self action:@selector(onAction:)];
        } else if (i.image)
        {
            item = [[UIBarButtonItem alloc] initWithImage:i.image style:UIBarButtonItemStylePlain target:self action:@selector(onAction:)];
        } else if (i.controllerAction.length)
        {
            item = [[UIBarButtonItem alloc] initWithTitle:i.title style:UIBarButtonItemStylePlain target:self action:@selector(onAction:)];
        } else {
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectNull];
            lab.text = i.title;
            lab.backgroundColor = [UIColor clearColor];
            [lab sizeToFit];
            item = [[UIBarButtonItem alloc] initWithCustomView:lab];
            item.target = self;
            item.action = @selector(onAction:);
        }
        
        item.width = i.width;
        item.enabled = i.enabled;
        item.tag = index++;
        [res addObject:item];
    }
    
    [res addObject:fixedSpace];
    self.items = res;

    return self;
}


@end
