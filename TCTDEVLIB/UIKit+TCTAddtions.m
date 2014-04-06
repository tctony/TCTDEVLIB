//
//  UIKit+TCTAddtions.m
//  TCTDEVLIB
//
//  Created by changtang on 3/27/14.
//  Copyright (c) 2014 TCTONY. All rights reserved.
//

#import "UIKit+TCTAddtions.h"
#import "TCTLogUtils.h"

@implementation UIWindow (TCTAddtions)

+ (UIWindow *)tct_applicationWindow
{
    return [UIApplication sharedApplication].delegate.window;
}

+ (UIWindow *)tct_currentWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    if (!window) { TCT_E(@"windows should not be nil!"); }
    return window;
}

@end


@implementation UIView (TCTAddtion)

- (CGFloat)tct_left
{
    return self.frame.origin.x;
}

- (void)setTct_left:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)tct_top
{
    return self.frame.origin.y;
}

- (void)setTct_top:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)tct_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setTct_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)tct_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setTct_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)tct_width
{
    return self.frame.size.width;
}

- (void)setTct_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)tct_height
{
    return self.frame.size.height;
}

- (void)setTct_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)tct_centerX
{
    return self.center.x;
}

- (void)setTct_centerX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)tct_centerY
{
    return self.center.y;
}

- (void)setTct_centerY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)tct_origin
{
    return self.frame.origin;
}

- (void)setTct_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)tct_size
{
    return self.frame.size;
}

- (void)setTct_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)tct_removeAllSubViews
{
    for (UIView *subView in [self subviews]) {
        [subView removeFromSuperview];
    }
}

- (NSArray *)tct_subViewsOfClass:(Class)viewClass
{
    NSArray *subViews = self.subviews;
    
    NSIndexSet *indices = [subViews indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj isKindOfClass:viewClass];
    }];
    
    if (indices) {
        return [subViews objectsAtIndexes:indices];
    }
    return @[];
}

- (UIView *)tct_snapshotView
{
    UIView *snapshotView = nil;
    
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        snapshotView = [self snapshotViewAfterScreenUpdates:NO];
    }
    else {
        UIImage *snapshotImage = [self tct_imageOfFrame:self.bounds];
        snapshotView = [[UIImageView alloc] initWithImage:snapshotImage];
    }
    
    return snapshotView;
}

- (UIImage *)tct_imageOfFrame:(CGRect)frame
{
    CGRect rect = self.bounds;
    
    if (UIGraphicsBeginImageContextWithOptions != nil) {
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    }
    else {
        UIGraphicsBeginImageContext(rect.size);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        CGContextTranslateCTM(context, -scrollView.contentOffset.x, -scrollView.contentOffset.y);
    }
    [self.layer renderInContext:context];
    UIImage *snapImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (CGRectEqualToRect(rect, frame)) {
        return snapImage;
    }
    else {
        CGFloat scale = snapImage.scale;
        CGRect cropRect = CGRectMake(CGRectGetMinX(frame)*scale, CGRectGetMinY(frame)*scale, CGRectGetWidth(frame)*scale, CGRectGetHeight(frame)*scale);
        CGImageRef imageRef = CGImageCreateWithImageInRect(snapImage.CGImage, cropRect);
        UIImage *img = [UIImage imageWithCGImage:imageRef scale:snapImage.scale orientation:snapImage.imageOrientation];
        CGImageRelease(imageRef);
        return img;
    }
}

- (UITapGestureRecognizer *)tct_addTapTarget:(id)target action:(SEL)selector
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
    [gesture addTarget:target action:selector];
    [self addGestureRecognizer:gesture];
    return gesture;
}

@end


@implementation UIGestureRecognizer (TCTAddtion)

- (void)tct_cancel
{
    if (self.enabled) {
        //It's a documented behavior to cancel a gesture by resetting its enabled state
        self.enabled = NO;
        self.enabled = YES;
    }
}

@end


@implementation UITableViewCell (TCTAddtion)

+ (NSString *)tct_reuseIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier", NSStringFromClass([self class])];
}

@end