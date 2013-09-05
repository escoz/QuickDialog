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

#import "QWebElement.h"
#import "QuickDialog.h"
@implementation QWebElement

@synthesize url = _url;
@synthesize html = _html;

- (QWebElement *)initWithTitle:(NSString *)title url:(NSString *)url {
    self = [super init];
    if (self!=nil){
        _url = url;
        _title = title;
    }
    return self;
}

- (QWebElement *)initWithTitle:(NSString *)title HTML:(NSString *)html {
	
    self = [super init];
    if (self!=nil){
        _url = nil;
        _title = title;
		_html = html;
    }
    return self;
}

-(void)setFile:(NSString *)filename {
    _url = [[NSBundle mainBundle] pathForResource:filename ofType:@"html"];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}


- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)path {
    [self handleElementSelected:controller];
	if (_html) {
		QWebViewController *webController = [[QWebViewController alloc] initWithHTML:_html];
        webController.title = self.title;
		[controller displayViewController:webController];
	}
	else {
        if ([_url hasPrefix:@"http"] || [_url hasPrefix:@"/"]) {
			QWebViewController *webController = [[QWebViewController alloc] initWithUrl:_url];
			[controller displayViewController:webController withPresentationMode:self.presentationMode];
		} else {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:_url]];
			[tableView deselectRowAtIndexPath:path animated:NO];
		}
	}
}
@end
