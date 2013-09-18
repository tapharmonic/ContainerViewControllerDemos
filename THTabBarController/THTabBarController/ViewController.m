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

#import "ViewController.h"
#import "THTabBarController.h"
#import "AppDelegate.h"
#import "ActionView.h"

@interface ViewController ()
@property(nonatomic, strong) NSArray *buttons;
@end

@implementation ViewController

+ (id)controllerWithTitle:(NSString *)title backgroundColor:(UIColor *)bgColor {
	UIViewController *controller = [[self alloc] initWithNibName:nil bundle:nil];
	controller.title = title;
	controller.view.backgroundColor = bgColor;
	return controller;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)loadView {
    self.view = [[ActionView alloc] initWithFrame:CGRectZero];
	NSMutableArray *buttons = [NSMutableArray array];
	[buttons addObject:[self buttonWithAction:@selector(anchorAtTop:)]];
	[buttons addObject:[self buttonWithAction:@selector(animateTransitions:)]];
	[buttons addObject:[self buttonWithAction:@selector(anchorAtBottom:)]];
	[(id)self.view setButtons:buttons];
}

- (UIButton *)buttonWithAction:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)anchorAtTop:(id)sender {
    THTabBarController *controller = [self customTabBarController];
    controller.animateTransitions = NO;
    controller.tabBarAnchor = THTabBarAnchorTop;
}

- (void)anchorAtBottom:(id)sender {
    THTabBarController *controller = [self customTabBarController];
    controller.animateTransitions = NO;
    controller.tabBarAnchor = THTabBarAnchorBottom;
}

- (void)animateTransitions:(id)sender {
    THTabBarController *controller = [self customTabBarController];
    controller.animateTransitions = YES;
}

- (THTabBarController *)customTabBarController {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    return delegate.tabBarController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"View Will Appear: %@", self.title);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"View Did Appear: %@", self.title);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"View Will Disappear: %@", self.title);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"View Did Disappear: %@", self.title);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"Will Rotate: %@", self.title);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"Will Animate Rotation: %@", self.title);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"Did Rotate: %@", self.title);
    [self.view setNeedsLayout];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
	[super willMoveToParentViewController:parent];
	NSLog(@"Will Move To Parent: %@", parent);
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
	[super didMoveToParentViewController:parent];
	NSLog(@"Did Move To Parent: %@", parent);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
