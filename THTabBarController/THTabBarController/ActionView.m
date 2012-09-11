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

#import "ActionView.h"
#import "UIView+THKitAdditions.h"

@implementation ActionView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)setButtons:(NSArray *)buttons {
    for (id button in _buttons) {
        [button removeFromSuperview];
    }
    _buttons = buttons;
    for (id button in _buttons) {
        [self addSubview:button];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    CGFloat x = 0, y = 0;
    CGFloat width = self.frameWidth, height = self.frameHeight / 3;
    for (UIButton *button in self.buttons) {
        button.frame = CGRectMake(x, y, width, height);
        y += height;
    }
}

@end
