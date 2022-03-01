//
//  MainTableView.h
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/13.
//
//此类为主页的TableView，即新闻列表
#import <UIKit/UIKit.h>
#import "NewsCell.h"
#import "EverydayNewsModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//代理
@protocol MainTableDelegate <NSObject>
@required
//数据传递，当滑到footerView的时候去触发加载Before数据
- (void)nextSectionBlock:(NSInteger)section;
//点击cell,把indexPath传给HomeViewController来进行页面跳转
- (void)gainIndexPath:(NSIndexPath *)indexPath;
//传递日期
- (NSString *)gainDate:(NSInteger)section;
//传递滚动信息
-(void)scrollViewWithIsScrolling:(BOOL)isScrolling offsetY:(CGFloat)offsetY;
@end

@interface MainTableView : UITableView
//代理
@property (nonatomic, weak)id <MainTableDelegate> mainDelegate;
//每天的新闻数据
@property (nonatomic, strong) NSMutableArray<DayModel *> *everydayNews;


@end

NS_ASSUME_NONNULL_END
