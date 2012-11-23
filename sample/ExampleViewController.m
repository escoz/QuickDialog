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

#import "ExampleViewController.h"

@implementation ExampleViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

-(void)handleWebElementControllerAction:(QWebElement *)element {
    NSLog(@"Web element selected for url %@", element.url);
}

-(void)handleChangeEntryExample:(QButtonElement *) button {
    QEntryElement *entry  = (QEntryElement *) [self.root elementWithKey:@"entryElement"];
    entry.textValue = @"Hello";
    [self.quickDialogTableView reloadCellForElements:entry, nil];

}

-(void)exampleAction:(QElement *)element{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey!" message:@"This is the exampleAction method in the ExampleViewController" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)displayViewControllerForRoot:(QRootElement *)element {

    QuickDialogController *newController = [QuickDialogController controllerForRoot:element];
    if (self.splitViewController!=nil){
        UINavigationController * navController = [self.splitViewController.viewControllers objectAtIndex:1];

        for (QSection *section in self.root.sections) {
            for (QElement *current in section.elements){
                if (current==element) {
                    self.splitViewController.viewControllers = @[[self.splitViewController.viewControllers objectAtIndex:0], [[UINavigationController alloc] initWithRootViewController:newController]];
                    return;
                }
            }
        }
        [navController pushViewController:newController animated:YES];
    } else {
        [super displayViewController:newController];
    }
}

@end
