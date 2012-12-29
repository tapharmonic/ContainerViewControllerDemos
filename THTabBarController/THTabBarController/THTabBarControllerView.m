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

#import "THTabBarControllerView.h"
#import "UIView+THKitAdditions.h"
#import <QuartzCore/QuartzCore.h>

#define TAB_BAR_HEIGHT 49

@interface THTabBarControllerView ()
@property(nonatomic, strong) THTabBarView *tabBarView;
@property(nonatomic, strong) UIView *contentView;
@end

@implementation THTabBarControllerView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        CGRect tabBarFrame = CGRectMake(0, self.bounds.size.height - TAB_BAR_HEIGHT, self.bounds.size.width, TAB_BAR_HEIGHT);
        _tabBarView = [[THTabBarView alloc] initWithFrame:tabBarFrame];
        [self addSubview:self.tabBarView];

        UIImage *bgImage = [UIImage imageNamed:@"linen"];
        self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
        _tabBarAnchor = THTabBarAnchorBottom;
    }
    return self;
}

- (void)setTabBarAnchor:(THTabBarAnchor)tabBarAnchor {
    _tabBarAnchor = tabBarAnchor;
    if (self.tabBarAnchor == THTabBarViewAnchorTop) {
        _tabBarView.frame = CGRectMake(0, 0, self.bounds.size.width, TAB_BAR_HEIGHT);
        _tabBarView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    } else {
        _tabBarView.frame = CGRectMake(0, self.bounds.size.height - TAB_BAR_HEIGHT, self.bounds.size.width, TAB_BAR_HEIGHT);
        _tabBarView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    }
	_contentView.frame = [self contentFrameForCurrentAnchorPosition];
    [self setNeedsLayout];
}

- (CGRect)contentFrameForCurrentAnchorPosition {
    CGRect frame;
    if (self.tabBarAnchor == THTabBarAnchorTop) {
        frame = CGRectMake(0, TAB_BAR_HEIGHT, self.bounds.size.width, self.bounds.size.height - self.tabBarView.bounds.size.height);
    } else {
        frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - self.tabBarView.bounds.size.height);
    }
    return frame;
}

- (void)setContentView:(UIView *)newContentView animated:(BOOL)animated options:(THTabBarAnimationOption)options {
    if (!_contentView) {
        // Content view must be set by simple assignment.  Do not retain!!
        newContentView.frame = [self contentFrameForCurrentAnchorPosition];
        _contentView = newContentView;
        [self addSubview:_contentView];
        [self sendSubviewToBack:_contentView];
    } else {

        UIView *oldContentView = _contentView;

        if (!animated) {
            newContentView.frame = [self contentFrameForCurrentAnchorPosition];
            _contentView = newContentView;
            [self addSubview:_contentView];
            [self sendSubviewToBack:_contentView];
            [oldContentView removeFromSuperview];
        } else {

			// Determine the adjustment of the x-coordinate based on animation option
            CGFloat xAmount = (options == THTabBarAnimationOptionLeftToRight) ? -_contentView.frameWidth : _contentView.frameWidth;

            newContentView.frame = oldContentView.frame;
            // adjust x-position
            newContentView.frameX = xAmount;
            _contentView = newContentView;

            [self addSubview:_contentView];
            [self sendSubviewToBack:_contentView];

            CALayer *oldLayer = [self decorateLayerWithShadow:oldContentView.layer];
            CALayer *newLayer = [self decorateLayerWithShadow:newContentView.layer];

			self.userInteractionEnabled = NO;
            [UIView animateWithDuration:0.25f animations:^{
                CATransform3D scaledTransform = CATransform3DScale(CATransform3DIdentity, 0.85f, 0.85f, 1.0f);
                oldLayer.transform = scaledTransform;
                newLayer.transform = scaledTransform;
            } completion:^(BOOL complete) {
                [UIView animateWithDuration:0.4
									  delay:0.1f
									options:UIViewAnimationOptionCurveEaseInOut
								 animations:^{
                                     oldContentView.frameX -= xAmount;
                                     newContentView.frameX -= xAmount;
                                 } completion:^(BOOL finished) {
                                     [UIView animateWithDuration:0.25f
														   delay:0.1f
														 options:UIViewAnimationOptionCurveEaseInOut
													  animations:^{
														  oldLayer.transform = CATransform3DIdentity;
														  newLayer.transform = CATransform3DIdentity;
													  } completion:^(BOOL finished) {
														  [oldContentView removeFromSuperview];
														  [_contentView setNeedsLayout];
														  self.userInteractionEnabled = YES;
													  }];
                                 }];
            }];
        }
    }
}

- (CALayer *)decorateLayerWithShadow:(CALayer *)layer {
    layer.shadowColor = [UIColor darkGrayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    layer.shadowOpacity = 1.0f;
    layer.shadowRadius = 5.0f;
    layer.shouldRasterize = YES;
    return layer;
}

@end
