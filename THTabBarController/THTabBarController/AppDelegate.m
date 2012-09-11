//
//  MIT License
//
//  Copyright (c) 2012 TapHarmonic, LLC http://tapharmonic.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Written by Bob McCune http://bobmccune.com for 360iDev 2012.
//

#import "AppDelegate.h"
#import "THTabBarController.h"
#import "ViewController.h"
#import "THTabBarItem.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    ViewController *vc1 = [ViewController controllerWithTitle:@"First VC" backgroundColor:[UIColor greenColor]];
	ViewController *vc2 = [ViewController controllerWithTitle:@"Second VC" backgroundColor:[UIColor blueColor]];
	ViewController *vc3 = [ViewController controllerWithTitle:@"Third VC" backgroundColor:[UIColor redColor]];
	ViewController *vc4 = [ViewController controllerWithTitle:@"Fourth VC" backgroundColor:[UIColor yellowColor]];

    _tabBarController = [[THTabBarController alloc] init];

    self.tabBarController.tabBarItems = (@[
										 [THTabBarItem itemWithImageName:@"Search" controller:vc1],
										 [THTabBarItem itemWithImageName:@"User" controller:vc2],
										 [THTabBarItem itemWithImageName:@"Downloads" controller:vc3],
										 [THTabBarItem itemWithImageName:@"Favorites" controller:vc4]]
										 );

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
