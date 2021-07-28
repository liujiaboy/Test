//
//  Person+B.h
//  OC-Test
//
//  Created by Alan on 2021/7/25.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (B)

@property (nonnull, copy) NSString *name;
- (void)sayB;

@end

NS_ASSUME_NONNULL_END
