//
//  BannerView.h
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/14.
//
//此类为Banner作为TableView的headerView
#import <UIKit/UIKit.h>
#import "BannerModel.h"
NS_ASSUME_NONNULL_BEGIN
//代理
@protocol BannerDelegate <NSObject>
@required
//banner新闻跳转
- (void)deliverBannerID:(NSString *)ID;
@end

@interface BannerView : UIView <UIGestureRecognizerDelegate>
//代理
@property (nonatomic, weak)id <BannerDelegate> bannerDelegate;
@property (nonatomic, strong) NSArray<BannerModel *> *dataArray;
@property (nonatomic,assign) BOOL isScrolling;
@property (nonatomic,assign) CGFloat offsetY;

- (NSInteger)currentPage;

@end

NS_ASSUME_NONNULL_END

