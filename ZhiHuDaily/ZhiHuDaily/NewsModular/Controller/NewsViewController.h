//
//  NewsViewController.h
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/17.
//
//新闻详情页的Controller，用于请求网络，调度model里面的数据与view的内容展示
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsViewController : UIViewController
//根据传进来的ID去请求并创建一个新闻详情页
- (NewsViewController *)initWithID:(NSString *)URL;
@end

NS_ASSUME_NONNULL_END
