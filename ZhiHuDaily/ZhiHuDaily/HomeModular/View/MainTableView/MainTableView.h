//
//  MainTableView.h
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/13.
//
//此类为主页的TableView
#import <UIKit/UIKit.h>
#import "NewsCell.h"
#import "EverydayNewsModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//代理
@protocol MainTableDelegate <NSObject>
@required
//banner滑动放大
- (void)bannerOffset:(CGPoint)offset;
@end

@interface MainTableView : UITableView
//代理
@property (nonatomic, weak)id <MainTableDelegate> mainDelegate;
//数据传递，当滑到footerView的时候去触发加载Before数据
@property (nonatomic, copy) void(^nextSectionBlock)(NSInteger section);
//得到每日日期
@property (nonatomic, copy) NSString *(^gainDate)(NSInteger section);
//点击cell,把indexPath传给HomeViewController来进行页面跳转
@property (nonatomic, copy) void(^deliverTheIndexPath)(NSIndexPath* indexPath);
@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong)EverydayNewsModel *everydayModel;
//创建cell的方法
- (NewsCell *)creatFromTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
