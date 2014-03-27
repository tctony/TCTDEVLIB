//
//  UIKit+TCTAddtions.m
//  TCTDEVLIB
//
//  Created by changtang on 3/27/14.
//  Copyright (c) 2014 TCTONY. All rights reserved.
//

#import "UIKit+TCTAddtions.h"

@implementation UIWindow (TCTAddtions)

@end

@implementation UIView (TCTAddtion)

- (CGFloat)tct_width
{
    return self.frame.size.width;
}

- (CGFloat)tct_height
{
    return self.frame.size.height;
}

- (CGFloat)tct_left
{
    return self.frame.origin.x;
}

- (CGFloat)tct_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)tct_top
{
    return self.frame.origin.y;
}

- (CGFloat)tct_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (UITapGestureRecognizer *)tct_addTapTarget:(id)target action:(SEL)selector
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
    [gesture addTarget:target action:selector];
    [self addGestureRecognizer:gesture];
    return gesture;
}

@end