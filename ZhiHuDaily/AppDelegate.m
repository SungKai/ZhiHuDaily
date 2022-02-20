//
//  AppDelegate.m
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/17.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ManagerViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    homeVC.homeDelegate = self.managerVC;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    self.window.rootViewController = nav;
    nav.navigationBar.hidden = YES;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 懒加载
- (ManagerViewController *)managerVC{
    if (!_managerVC){
        _managerVC = [[ManagerViewController alloc]init];
    }
    return _managerVC;
}
@end
