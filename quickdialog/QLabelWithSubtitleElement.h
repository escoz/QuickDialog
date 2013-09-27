//
//  QLabelElementWithSubtitle.h
//  QuickDialog
//
//  Created by Hugo Doria on 9/27/13.
//
//

#import "QLabelElement.h"

@interface QLabelWithSubtitleElement : QRootElement {
    
@protected
    id _value;
    UIImage *_image;
}

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, assign) NSString *imageNamed;
@property(nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property(nonatomic, strong) id value;
@property (nonatomic, strong) NSString *subtitle;
@property(nonatomic) BOOL keepSelected;

- (QLabelWithSubtitleElement *)initWithTitle:(NSString *)string Value:(id)value;
- (void)setIconNamed:(NSString *)name;

@end
