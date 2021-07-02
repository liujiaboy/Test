//
//  AppDelegate.m
//  OC-Test
//
//  Created by Alan on 2021/6/21.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    dispatch_queue_t t =dispatch_queue_create("com", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t t = dispatch_queue_create("com", DISPATCH_QUEUE_SERIAL);
//    t = dispatch_get_main_queue();
    t = dispatch_get_global_queue(0, 0);
    
    // 异步 + 并发 开辟子线
    // 异步 + 串行 开辟子线
    // 异步 + main 不开辟子线
    // 异步 + global 开辟子线
    
//    dispatch_async(t, ^{
//        NSLog(@"1 =%@", [NSThread currentThread]);
//    });
//    dispatch_async(t, ^{
//        NSLog(@"2 =%@", [NSThread currentThread]);
//    });
    
    // 同步 + 并发 不开辟子线
    // 同步 + 串行 不开辟子线
//    NSLog(@"main label = %s", dispatch_queue_get_label(dispatch_get_main_queue()));
//    NSLog(@"g label = %s", dispatch_queue_get_label(t));
//    dispatch_sync(t, ^{
//        //
//        NSLog(@"2 =%@", [NSThread currentThread]);
//    });
//
//    dispatch_sync(t, ^{
//        //
//        NSLog(@"3 =%@", [NSThread currentThread]);
//    });
//
//    NSLog(@"4 =%@", [NSThread currentThread]);
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
