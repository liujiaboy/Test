//
//  AView.m
//  OC-Test
//
//  Created by Alan on 2021/6/22.
//

#import "AView.h"

@implementation AView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"Aview HitTest ...");
//    return [super hitTest:point withEvent:event];
//    return self;
    
    
    UIView *touchView = self;
    if ([self pointInside:point withEvent:event] &&
       (!self.hidden) &&
       self.userInteractionEnabled &&
       (self.alpha >= 0.01f)) {
        for (UIView *subView in self.subviews) {
            CGPoint subPoint = [subView convertPoint:point fromView:self];
            UIView *subTouchView = [subView hitTest:subPoint withEvent:event];
            if (subTouchView) {
                touchView = subTouchView;
                break;
            }
        }
    } else {
        touchView = nil;
    }
    return touchView;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"Aview inside %@", NSStringFromCGPoint(point));
    return [super pointInside:point withEvent:event];
}

@end
