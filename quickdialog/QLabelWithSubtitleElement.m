//
//  QLabelElementWithSubtitle.m
//  QuickDialog
//
//  Created by Hugo Doria on 9/27/13.
//
//

#import "QLabelWithSubtitleElement.h"
#import "QTableViewCellWithSubtitle.h"

@implementation QLabelWithSubtitleElement  {
@private
    UITableViewCellAccessoryType _accessoryType;
}


@synthesize image = _image;
@synthesize value = _value;
@synthesize accessoryType = _accessoryType;
@synthesize keepSelected = _keepSelected;
@synthesize subtitle = _subtitle;

- (QLabelWithSubtitleElement *)initWithTitle:(NSString *)title Value:(id)value {
    self = [super init];
    _title = title;
    _value = value;
    _keepSelected = YES;
    return self;
}

-(void)setImageNamed:(NSString *)name {
    self.image = [UIImage imageNamed:name];
}

- (NSString *)imageNamed {
    return nil;
}

-(void)setIconNamed:(NSString *)name {
#if __IPHONE_7_0
    self.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
#endif
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller
{
    QTableViewCellWithSubtitle *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"QuickformElementCell%@%@", self.key, self.class]];
    if (cell == nil){
        cell = [[QTableViewCellWithSubtitle alloc] initWithReuseIdentifier:[NSString stringWithFormat:@"QuickformElementCell%@%@", self.key, self.class]];
    }
   
    [cell applyAppearanceForElement:self];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _title;
    cell.detailTextLabel.text = [_value description];
    cell.imageView.image = _image;
    cell.subtitle.text = _subtitle;
    cell.accessoryType = _accessoryType != UITableViewCellAccessoryNone ? _accessoryType : self.controllerAccessoryAction != nil ? UITableViewCellAccessoryDetailDisclosureButton : ( self.sections!= nil || self.controllerAction!=nil ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone);
    cell.selectionStyle = self.sections!= nil || self.controllerAction!=nil || self.onSelected!=nil ? UITableViewCellSelectionStyleBlue: UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    [super selected:tableView controller:controller indexPath:path];
    if (!self.keepSelected)
        [tableView deselectRowAtIndexPath:path animated:YES];
}

@end
