//
//  UIKit+TCTAddtions.h
//  TCTDEVLIB
//
//  Created by changtang on 3/27/14.
//  Copyright (c) 2014 TCTONY. All rights reserved.
//

@interface UIWindow (TCTAddtion)

+ (UIWindow *)tct_applicationWindow;
+ (UIWindow *)tct_currentWindow;

@end

@interface UIView (TCTAddtion)

@property (nonatomic) CGFloat tct_left;
@property (nonatomic) CGFloat tct_top;
@property (nonatomic) CGFloat tct_right;
@property (nonatomic) CGFloat tct_bottom;
@property (nonatomic) CGFloat tct_width;
@property (nonatomic) CGFloat tct_height;
@property (nonatomic) CGFloat tct_centerX;
@property (nonatomic) CGFloat tct_centerY;
@property (nonatomic) CGPoint tct_origin;
@property (nonatomic) CGSize  tct_size;


- (void)tct_removeAllSubViews;
- (NSArray *)tct_subViewsOfClass:(Class)viewClass;

- (UIView *)tct_snapshotView;
- (UIImage *)tct_imageOfFrame:(CGRect)frame;

- (UITapGestureRecognizer *)tct_addTapTarget:(id)target action:(SEL)selector;

@end
