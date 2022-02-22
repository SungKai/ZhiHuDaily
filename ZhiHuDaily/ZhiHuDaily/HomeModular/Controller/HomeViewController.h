//
//  HomeViewController.h
//  ZhihuDemoAFN_MJ
//
//  Created by 宋开开 on 2022/2/2.
//

//此类为主页的控制器，用于加载所有主页内容，
#import <UIKit/UIKit.h>
#import "EverydayNewsModel.h"
NS_ASSUME_NONNULL_BEGIN
//代理
@protocol HomeViewControllerDelegate <NSObject>
@required
//点击cell,把ID传给ManagerViewController
- (UIViewController *)deliverTheID:(NSString *)ID;
//点击头像，跳转到登陆页
- (UIViewController *)jumpToLogin;

@end

@interface HomeViewController : UIViewController
//代理
@property (nonatomic, weak)id<HomeViewControllerDelegate> homeDelegate;
//当下滑到每一组最后一个cell时，调用此方法来网络请求前一天的数据
- (void)nextSection:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
