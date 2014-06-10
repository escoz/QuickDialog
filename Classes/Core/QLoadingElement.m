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

#import "QLoadingElement.h"

@implementation QLoadingElement {
}

- (instancetype)init {
    self = [super init];
    self.indicatorStyle = UIActivityIndicatorViewStyleGray;
    return self;
}

- (void)setCurrentCell:(UITableViewCell *)cell
{
    super.currentCell = cell;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIActivityIndicatorView *spin;

    if (self.activityIndicatorClass != nil)
        spin = [self.activityIndicatorClass new];
    else
        spin = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.indicatorStyle];

    [spin startAnimating];
    [spin sizeToFit];
    if (self.title == nil){
        CGFloat posX = (self.currentTableView.frame.size.width)/2;
        spin.center = CGPointMake(posX, self.height/2);
    } else {
        CGFloat posX = (self.currentTableView.frame.size.width-(spin.frame.size.width/2)-16);
        spin.center = CGPointMake(posX, self.height/2);
    }

    [[cell contentView] addSubview:spin];
    cell.textLabel.text = self.title;

}

- (void)handleAction:(UIViewController *)controller {
    // do nothing

}


@end
