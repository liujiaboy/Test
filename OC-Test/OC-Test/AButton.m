//
//  AButton.m
//  OC-Test
//
//  Created by Alan on 2021/6/25.
//

#import "AButton.h"
#import <objc/runtime.h>

static char *topNameKey = "topNameKey";
static char *rightNameKey = "rightNameKey";
static char *bottomNameKey = "bottomNameKey";
static char *leftNameKey = "leftNameKey";

@implementation AButton

#pragma mark - Button 增加点击区域 方案1
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    // 当前btn的大小
//    CGRect btnBounds=self.bounds;
//    // 扩大按钮的点击范围，改为负值
//    btnBounds=CGRectInset(btnBounds, -20, -20);
//    // 若点击的点在新的bounds里，就返回YES
//    return CGRectContainsPoint(btnBounds, point);
//}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"AButton HitTest...");
    return [super hitTest:point withEvent:event];
}

#pragma mark - Button 增加点击区域 方案2
#pragma mark- 利用 **runtime** 具体的设置内边距
// 设置可点击范围到按钮上、右、下、左的距离
-(void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);

}
//-------------------------------------------------------------------------------------------------------------
-(CGRect)enlargedRect
{
    NSNumber *topEdge=objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge=objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge=objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge=objc_getAssociatedObject(self, &leftNameKey);
    if(topEdge && rightEdge && bottomEdge && leftEdge){
        return CGRectMake(self.bounds.origin.x-leftEdge.floatValue,
                          self.bounds.origin.y-topEdge.floatValue,
                          self.bounds.size.width+leftEdge.floatValue+rightEdge.floatValue,
                          self.bounds.size.height+topEdge.floatValue+bottomEdge.floatValue);
    }
    else{
        return self.bounds;
    }
}

// 设置可点击范围到按钮上、右、下、左的距离
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"Abutton inside %@", NSStringFromCGPoint(point));
    CGRect rect = [self enlargedRect];
    if(CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point)?YES:NO;
}

@end
