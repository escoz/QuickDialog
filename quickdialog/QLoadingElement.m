//
// Copyright 2011 ESCOZ Inc  - http://escoz.com
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//


@implementation QLoadingElement {
@private
    UIActivityIndicatorViewStyle _indicatorStyle;
}
@synthesize indicatorStyle = _indicatorStyle;
@synthesize textLabel = _textLabel;

- (QLoadingElement *)init {
    if (self = [super init]) {
        self.indicatorStyle = UIActivityIndicatorViewStyleGray;
        _textLabel = [UILabel new];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller
{
    UITableViewCell *const cell = [[QTableViewCell alloc] init];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UIActivityIndicatorView *spin = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.indicatorStyle];
    [spin startAnimating];
    [spin sizeToFit];

    [_textLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [_textLabel sizeToFit];
    [_textLabel setFrame:CGRectMake(spin.frame.size.width + 10, 0, _textLabel.frame.size.width, _textLabel.frame.size.height)];

    CGFloat viewWidth = _textLabel.frame.size.width + spin.frame.size.width + (_textLabel.text ? 10 : 0);
    CGFloat viewHeight = MAX(_textLabel.frame.size.height, spin.frame.size.height);
    CGFloat viewX = (320 - viewWidth) / 2;

    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(viewX, 12, viewWidth, viewHeight)];
    container.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
            UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;

    [container addSubview:spin];
    [container addSubview:_textLabel];
    [cell.contentView addSubview:container];

    return cell;
}

- (void)handleElementSelected:(QuickDialogController *)controller {
    // do nothing

}


@end