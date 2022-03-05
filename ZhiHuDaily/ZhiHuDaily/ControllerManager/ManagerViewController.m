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
@interface ManagerViewController ()

@end

@implementation ManagerViewController
//单例模式
+ (instancetype)share{
    static ManagerViewController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
#pragma mark - <HomeViewControllerDelegate>

//跳转到新闻详情页
- (UIViewController *)deliverTheID:(NSString *)ID{
    //通过ID来找到新闻详情页
    NewsViewController *newsController = [[NewsViewController alloc]initWithID:ID];
    return newsController;
}
//跳转到个人登陆页
- (UIViewController *)jumpToLogin{
    //跳转到合适的个人登陆页
    PersonViewController *personViewController = [[PersonViewController alloc]init];
    return personViewController;
}
@end
