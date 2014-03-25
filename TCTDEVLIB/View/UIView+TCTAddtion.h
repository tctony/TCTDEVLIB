//
//  UIView+TCTAddtion.h
//  TCTDEVLIB
//
//  Created by Tony Tang on 14-3-24.
//  Copyright (c) 2014年 TCTONY. All rights reserved.
//



@interface UIView (TCTAddtion)

- (CGFloat)tct_width;
- (CGFloat)tct_height;
- (CGFloat)tct_left;
- (CGFloat)tct_right;
- (CGFloat)tct_top;
- (CGFloat)tct_bottom;

- (UITapGestureRecognizer *)tct_addTapTarget:(id)target action:(SEL)selector;

@end
