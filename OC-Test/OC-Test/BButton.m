//
//  BButton.m
//  OC-Test
//
//  Created by Alan on 2021/7/2.
//

#import "BButton.h"

@implementation BButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"B Button HitTest...");
    return [super hitTest:point withEvent:event];
}

// 设置可点击范围到按钮上、右、下、左的距离
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"B Button inside %@", NSStringFromCGPoint(point));
    if (self.isAnimate) {
        CGPoint ps = [self convertPoint:point toView:self.superview];
        if ([self.layer.presentationLayer hitTest:ps]) {
            return YES;
        }
    }
    return [super pointInside:point withEvent:event];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    if (self.isAnimate) {
//        CGPoint ps = [touches.anyObject locationInView:self.superview];
//        if ([self.layer.presentationLayer hitTest:ps]) {
//            [super touchesBegan:touches withEvent:event];
//        }
//    }
//    else {
//        [super touchesBegan:touches withEvent:event];
//    }
//}

@end
