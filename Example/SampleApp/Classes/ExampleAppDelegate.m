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
// permissions and limitatio    ns under the License.
//

#import "SampleDataBuilder.h"
#import "ExampleViewController.h"
#import "ExampleAppDelegate.h"

@implementation ExampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Sample root contains the data about the form, but none of the views
    QRootElement *root = [SampleDataBuilder create];

    // ExampleViewController is a subclass of QuickDialogController
    ExampleViewController *exampleController = [[ExampleViewController alloc] initWithRoot:root];

    // Wrap in a navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:exampleController];

    // Set as default root controller (with a split view controller on iPad
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        self.window.rootViewController = nav;
    } else {
        UISplitViewController *split = [[UISplitViewController alloc] init];
        split.delegate = self;
        split.viewControllers = @[nav, [[UINavigationController alloc] initWithRootViewController:[QuickDialogController new]]];
        self.window.rootViewController = split;
    }
    [self.window makeKeyAndVisible];

    return YES;
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    return NO;
}


@end
