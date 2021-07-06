//
//  TStaticViewController.h
//  TestStaticFR
//
//  Created by Alan on 2021/7/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TStaticViewController : UIViewController

@property (nonatomic, copy) void(^buttonClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
