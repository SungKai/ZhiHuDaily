//
//  ManagerViewController.h
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/17.
//
//此类用于处理所有跳转事件（点击cell跳转到新闻详情页，点击头像跳转到个人页）
#import <UIKit/UIKit.h>
#import "HomeViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ManagerViewController : UIViewController <HomeViewControllerDelegate>
+ (instancetype)share;

@end

NS_ASSUME_NONNULL_END
