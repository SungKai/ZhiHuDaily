//
//  ManagerViewController.m
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/17.
//

#import "ManagerViewController.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "PersonViewController.h"
@interface ManagerViewController () <HomeViewControllerDelegate>

@end

@implementation ManagerViewController
#pragma mark - <HomeViewControllerDelegate>
//跳转到新闻详情页
- (UIViewController *)deliverTheID:(NSString *)ID{
    NewsViewController *newsController = [[NewsViewController alloc]initWithID:ID];
    return newsController;
}
//跳转到个人登陆页
- (UIViewController *)jumpToLogin{
    PersonViewController *personViewController = [[PersonViewController alloc]init];
    return personViewController;
}
@end
