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

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    QRootElement *root = [SampleDataBuilder create];
    ExampleViewController *quickformController = (ExampleViewController *) [[ExampleViewController alloc] initWithRoot:root];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:quickformController];
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        self.window.rootViewController = nav;
    } else {
        UISplitViewController *split = [[UISplitViewController alloc] init];
        split.delegate = self;
        split.viewControllers = @[nav, [[UINavigationController alloc] initWithRootViewController:[QuickDialogController new]]];
        self.window.rootViewController = split;
    }
    [self.window makeKeyAndVisible];

    [self runAppearanceTests];
    return YES;
}

- (void)runAppearanceTests {
    /*QAppearance * defaultAppearance = [QElement appearance];
    [defaultAppearance setObject:@"test" forKey:@"test"];
    NSAssert(QElement.appearance!=nil, @"appearance on QElement must not be nil", nil);
    NSAssert(QRootElement.appearance!=nil, @"appearance on subclass of QElement must not be nil", nil);
    NSAssert([QRootElement appearance] == defaultAppearance, @"appearance by default should be the same in a subclass", nil);

    NSAssert([QElement new].appearance!=nil, @"appearance on object of QElement subclass should be a mutable copy of the default", nil);
    NSAssert([QRootElement new].appearance!=nil, @"appearance on object of QElementshould be a mutable copy of the default", nil);


    NSAssert([QElement new].appearance!=[QRootElement new].appearance, @"instance appearances shouldn't by default be the same, they're different mutable copies", nil);

    NSAssert([[[QElement new].appearance objectForKey:@"test"] isEqualToString:@"test"], @"appearance on object of QElement subclass should be a mutable copy of the default", nil);
    NSAssert([[[QRootElement new].appearance objectForKey:@"test"] isEqualToString:@"test"], @"appearance on object of QElementshould be a mutable copy of the default", nil);

    QRootElement.appearance = [QAppearance new];
    NSAssert([[[QElement new].appearance objectForKey:@"test"] isEqualToString:@"test"], @"after changing QRoot, QElement should still have original", nil);

    //NSAssert([QRootElement new].appearance!=QRootElement.appearance, @"appearance on object of QRootElement should be new type", nil);
    NSAssert(![[[QRootElement new].appearance objectForKey:@"test"] isEqualToString:@"test"], @"appearance on object of QRootElement should be new type", nil);

    QRootElement.appearance = nil;
    NSAssert([[QRootElement.appearance valueForKey:@"test"] isEqualToString:@"test"], @"set to nil should revert to class appearance", nil);

    QElement *element = [QElement new];
    QRootElement *root = [QRootElement new];
    [element.appearance setObject:@"a" forKey:@"test"];
    [root.appearance setObject:@"b" forKey:@"test"];

    //NSAssert([[element.appearance valueForKey:@"test"] isEqualToString:@"a"], @"value set should stay set", nil);
    //NSAssert([[root.appearance valueForKey:@"test"] isEqualToString:@"b"], @"value set should stay set", nil);

    element.appearance = nil;
    //NSAssert([[element.appearance valueForKey:@"test"] isEqualToString:@"test"], @"set to nil should revert to class appearance", nil);

    // clear things out
    QElement.appearance = nil;
    QRootElement.appearance = nil;*/

}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    return NO;
}


@end
