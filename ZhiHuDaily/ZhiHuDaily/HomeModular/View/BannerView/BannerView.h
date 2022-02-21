//
//  BannerView.h
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/14.
//
//此类为Banner作为TableView的headerView
#import <UIKit/UIKit.h>
#import "DataModel.h"
NS_ASSUME_NONNULL_BEGIN
//代理
@protocol BannerDelegate <NSObject>
@required
//banner新闻跳转
- (void)deliverBannerID:(NSString *)ID;
@end
@interface BannerView : UITableView <UIGestureRecognizerDelegate>
//代理
@property (nonatomic, weak)id <BannerDelegate> bannerDelegate;
@property (nonatomic, strong) NSArray<DataModel *> *dataArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong, nullable) NSTimer *timer;
@property (nonatomic, strong) UIImageView *image;
- (void)reloadBanner;
@end

NS_ASSUME_NONNULL_END

