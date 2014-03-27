//
//  UIKit+TCTAddtions.h
//  TCTDEVLIB
//
//  Created by changtang on 3/27/14.
//  Copyright (c) 2014 TCTONY. All rights reserved.
//

@interface UIWindow (TCTAddtion)

@end

@interface UIView (TCTAddtion)

- (CGFloat)tct_width;
- (CGFloat)tct_height;
- (CGFloat)tct_left;
- (CGFloat)tct_right;
- (CGFloat)tct_top;
- (CGFloat)tct_bottom;

- (UITapGestureRecognizer *)tct_addTapTarget:(id)target action:(SEL)selector;

@end
