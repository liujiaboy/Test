//
//  Person+A.h
//  OC-Test
//
//  Created by Alan on 2021/7/25.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (A)

@property (nonnull, copy) NSString *name;
- (void)sayA;
@end

NS_ASSUME_NONNULL_END
