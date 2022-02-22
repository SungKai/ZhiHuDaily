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
//数据传递，当滑到footerView的时候去触发加载Before数据
- (void)nextSectionBlock:(NSInteger)section;
//得到每日日期
- (NSString *)gainDate:(NSInteger)section;
//点击cell,把indexPath传给HomeViewController来进行页面跳转
- (void)gainIndexPath:(NSIndexPath *)indexPath;
//让HomeViewController传递一个everydayModel.everydayNews给MainTableView，来在请求Before数据的时候判断，防止刷新率过高
- (NSInteger)everydayNewsCount;
//传递正在下滑的信息
- (void)scrollViewWithIsScrolling:(BOOL)isScrolling offsetY:(CGFloat)offsetY;
@end

@interface MainTableView : UITableView
//代理
@property (nonatomic, weak)id <MainTableDelegate> mainDelegate;
@property (nonatomic, copy) NSString *date;

//创建cell的方法
- (NewsCell *)creatFromTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
