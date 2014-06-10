//
//  QDAppDelegate.m
//  SampleApp
//
//  Created by Eduardo Scoz on 5/26/14.
//  Copyright (c) 2014 ESCOZ inc. All rights reserved.
//

#import "QDAppDelegate.h"
#import "ExampleViewController.h"
#import "SampleDataBuilder.h"

@implementation QDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    QRootElement *root = [SampleDataBuilder create];
    ExampleViewController *exampleController = [[ExampleViewController alloc] initWithRoot:root];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:exampleController];
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