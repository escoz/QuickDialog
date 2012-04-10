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

#import "IMSSearchDisplayController.h"
#import "SearchElement.h"

@interface QuickDialogController ()

+ (Class)controllerClassForRoot:(QRootElement *)root;

@end

@implementation QuickDialogController {
    BOOL _keyboardVisible;
    BOOL _viewOnScreen;
    BOOL _resizeWhenKeyboardPresented;
    BOOL _hasSearchBar;
    IMSSearchDisplayController *searchController;
}

@synthesize root = _root;
@synthesize willDisappearCallback = _willDisappearCallback;
@synthesize quickDialogTableView = _quickDialogTableView;
@synthesize resizeWhenKeyboardPresented = _resizeWhenKeyboardPresented;
@synthesize hasSearchBar = _hasSearchBar;
@synthesize searchController = _searchController;
@synthesize searchList = _searchList;
@synthesize filteredSearchList;
@synthesize searchType;

+ (QuickDialogController *)buildControllerWithClass:(Class)controllerClass root:(QRootElement *)root {
    controllerClass = controllerClass==nil? [QuickDialogController class] : controllerClass;
    return [((QuickDialogController *)[controllerClass alloc]) initWithRoot:root];
}

+ (QuickDialogController *)controllerForRoot:(QRootElement *)root {
    Class controllerClass = [self controllerClassForRoot:root];
    return [((QuickDialogController *)[controllerClass alloc]) initWithRoot:root];
}


+ (Class)controllerClassForRoot:(QRootElement *)root {
    Class controllerClass = nil;
    if (root.controllerName!=NULL){
        controllerClass = NSClassFromString(root.controllerName);
    } else {
        controllerClass = [self class];
    }
    return controllerClass;
}

+ (UINavigationController*)controllerWithNavigationForRoot:(QRootElement *)root {
    return [[UINavigationController alloc] initWithRootViewController:[QuickDialogController
                                                                       buildControllerWithClass:[self controllerClassForRoot:root]
                                                                       root:root]];
}

- (void)loadView {
    [super loadView];
    self.quickDialogTableView = [[QuickDialogTableView alloc] initWithController:self];
    self.view = self.quickDialogTableView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (QuickDialogController *)initWithRoot:(QRootElement *)rootElement {
    self = [super init];
    if (self) {
        self.root = rootElement;
        self.hasSearchBar = rootElement.hasSearchBar;
        self.searchType = rootElement.searchType;
        self.searchList = rootElement.searchList;
        self.resizeWhenKeyboardPresented =YES;
        self.groupedSearchResults = rootElement.groupedSearchResults;
    }
    return self;
}

- (void)setRoot:(QRootElement *)root {
    _root = root;
    self.quickDialogTableView.root = root;
    self.title = _root.title;
    self.navigationItem.title = _root.title;
}

- (void)viewWillAppear:(BOOL)animated {
    _viewOnScreen = YES;
    [self.quickDialogTableView viewWillAppear];
    [super viewWillAppear:animated];
    if (_root!=nil)
        self.title = _root.title;
    if (self.root.hasSearchBar)
    {
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 45.0f)];
        [searchBar sizeToFit];        
        searchBar.barStyle=UIBarStyleBlackTranslucent;
        searchBar.autocorrectionType=UITextAutocorrectionTypeNo;
        searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
        searchBar.tintColor = self.navigationController.navigationBar.tintColor;
        searchBar.placeholder = @"Search";
        
        _searchController = [[IMSSearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsDelegate = self;
        _searchController.searchResultsDataSource = self;
        self.quickDialogTableView.tableHeaderView = searchBar;
        self.searchList = self.root.searchList;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    _viewOnScreen = NO;
    [super viewWillDisappear:animated];
    if (_willDisappearCallback!=nil){
        _willDisappearCallback();
    }
}

- (void)popToPreviousRootElement {
    if (self.navigationController!=nil){
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)displayViewController:(UIViewController *)newController {
    if (self.navigationController != nil ){
        [self.navigationController pushViewController:newController animated:YES];
    } else {
        [self presentModalViewController:newController animated:YES];
    }
}

- (void)displayViewControllerForRoot:(QRootElement *)root {
    QuickDialogController *newController = [self controllerForRoot: root];
    [self displayViewController:newController];
}


- (QuickDialogController *)controllerForRoot:(QRootElement *)root {
    Class controllerClass = [[self class] controllerClassForRoot:root];
    return [QuickDialogController buildControllerWithClass:controllerClass root:root];
}


- (void) resizeForKeyboard:(NSNotification*)aNotification {
    if (!_viewOnScreen)
        return;

    BOOL up = aNotification.name == UIKeyboardWillShowNotification;

    if (_keyboardVisible == up)
        return;

    _keyboardVisible = up;
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];

    [UIView animateWithDuration:animationDuration delay:0 options:animationCurve
        animations:^{
            CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
            self.quickDialogTableView.contentInset = UIEdgeInsetsMake(0.0, 0.0,  up ? keyboardFrame.size.height : 0, 0.0);
        }
        completion:NULL];
}

- (void)setResizeWhenKeyboardPresented:(BOOL)observesKeyboard {
  if (observesKeyboard != _resizeWhenKeyboardPresented) {
    _resizeWhenKeyboardPresented = observesKeyboard;

    if (_resizeWhenKeyboardPresented) {
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resizeForKeyboard:) name:UIKeyboardWillShowNotification object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resizeForKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    } else {
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    }
  }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString 
{
    searchString = [[searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    NSInteger searchStringLength = [searchString length];
    NSString *searchStringNewWordBeginning = [NSString stringWithFormat:@" %@", searchString];
    NSString *searchStringNewWordEnding = [NSString stringWithFormat:@"%@ ", searchString];
    
    if (filteredSearchList == nil) 
    {
        filteredSearchList = [[NSMutableArray alloc] init];
    }
    else 
    {
        [filteredSearchList removeAllObjects];
    }
    
    BOOL searchMatchesBeginning, searchMatchesNewWordBeginning, searchMatchesSubstring = NO;
    
    for (int i = 0; i < _searchList.count; i++) 
    {
        NSObject* currentObject = [_searchList objectAtIndex:i];
        NSString *stringToMatch;
        if ([currentObject isKindOfClass:[SearchElement class]]) 
        {
            SearchElement* se = (SearchElement*)currentObject;
            stringToMatch = se.detail;
            
            stringToMatch = [stringToMatch lowercaseString];
            
            if ([searchString length] <= [stringToMatch length]) 
            {
                if (searchType == IMSTableSearchTypeBeginningOnly || searchType == IMSTableSearchTypeWordBeginning) 
                {
                    searchMatchesBeginning = [[stringToMatch substringToIndex:searchStringLength] isEqualToString:searchString];
                }
                if (searchType == IMSTableSearchTypeWordBeginning) 
                {
                    searchMatchesNewWordBeginning = ([stringToMatch rangeOfString:searchStringNewWordBeginning].location != NSNotFound);
                }
                if (searchType == IMSTableSearchTypeEndingOnly || searchType == IMSTableSearchTypeWordEnding) 
                {
                    searchMatchesBeginning = NO;
                    NSInteger fromIndex = [stringToMatch length] - searchStringLength;
                    if (fromIndex > 0) 
                    {
                        searchMatchesBeginning = [[stringToMatch substringFromIndex:fromIndex] isEqualToString:searchString];
                    }
                }
                if (searchType == IMSTableSearchTypeWordEnding) 
                {
                    searchMatchesNewWordBeginning = ([stringToMatch rangeOfString:searchStringNewWordEnding].location != NSNotFound);
                }
                if (searchType == IMSTableSearchTypeSubstring) 
                {
                    searchMatchesSubstring = ([stringToMatch rangeOfString:searchString].location != NSNotFound);
                }
                if (searchMatchesBeginning || searchMatchesNewWordBeginning || searchMatchesSubstring) 
                {
                    [filteredSearchList addObject:currentObject];
                }
            }
        }
    }
    return YES;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    if (tableView == self.searchController.searchResultsTableView) 
    {
        if ([filteredSearchList count] > 0)
        {
            return 1;
        }
        else 
        {
            return 0;
        }
    } 
    else 
    {
        return [_searchList count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchController.searchResultsTableView) 
    {
        return [filteredSearchList count];
    } 
    else 
    {
        return [[filteredSearchList objectAtIndex:section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSObject *currentObject;
    if (tableView == self.searchController.searchResultsTableView) 
    {
        currentObject = [filteredSearchList objectAtIndex:indexPath.row];
    }
    
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
	}

    SearchElement* se = (SearchElement*)currentObject;
	cell.textLabel.text = se.detail;
	return cell;
}

@end
