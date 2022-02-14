//
//  AppDelegate.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#import "AppDelegate.h"
#import "GBYNavigationController.h"
#import "GBYHomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    GBYHomeViewController *homeVC = [[GBYHomeViewController alloc] init];
    GBYNavigationController *nav = [[GBYNavigationController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
