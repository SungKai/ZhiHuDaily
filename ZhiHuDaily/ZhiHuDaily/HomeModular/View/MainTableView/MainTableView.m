//
//  MainTableView.m
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/13.
//
#define DEVICESCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define DEVICESCREENHEIGHT [[UIScreen mainScreen]bounds].size.height
#import "MainTableView.h"
#import "EverydayNewsModel.h"
#import "DateHeaderView.h"
#import "NewsCell.h"
#import "HomeViewController.h"
@interface MainTableView ()<UITableViewDelegate, UIScrollViewDelegate>

@end
@implementation MainTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self){
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
#pragma mark - 懒加载
- (NSString *)date{
    if (!_date){
        _date = [NSString string];
    }
    return _date;
}
#pragma mark - 方法
//创建一个cell
- (NewsCell *)creatFromTableView:(UITableView *)tableView{
    return [NewsCell creatCellDefault:tableView];
}
#pragma mark - <UITableViewDelegate>
//每当拉到每个section的FooterView就加载Before数据
- (void)tableView:(UITableView *)tableView
willDisplayFooterView:(nonnull UIView *)view forSection:(NSInteger)section{
    if (self.nextSectionBlock && (self.everydayModel.everydayNews.count == section + 1)) {
        self.nextSectionBlock(section);
    }
}
//设置footerView
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorNamed:@"255_255_255&26_26_26"];
    return view;
}
//设置DateView为TableView的headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *date = self.gainDate(section);
    NSInteger month = [[date substringWithRange:NSMakeRange(4, 2)] integerValue];
    NSInteger day = [[date substringFromIndex:6] integerValue];
    DateHeaderView *dateHeaderView = [[DateHeaderView alloc]initWithDateHeaderViewWithDate:[NSString stringWithFormat:@"%ld月%ld日", month, day]];
        return dateHeaderView;
}
//设置footerView为高度极小的一个View
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//Header的高度设置，第一行无
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //要设置日期
    if (section == 0){
        return 0;
    }else{
        return 30;
    }
}
//每一个cell的高度为105
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 105;
}
//单击跳转新闻详情页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [self cellForRowAtIndexPath:indexPath];
    cell.title.textColor = [UIColor colorNamed:@"152_152_152&&101_101_101"];
    self.deliverTheIndexPath(indexPath);
}
#pragma mark - 滚动放大
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //原理：获得scrollView
//    if (scrollView.contentOffset.y <= 0) {
//    NSLog(@"\n\t- %@", NSStringFromCGPoint(scrollView.contentOffset));
//        NSLog(@"vffffffffffff        %f", scrollView.contentOffset.y);
//        //把scrollView.contentOffset传到
//        [self.mainDelegate bannerOffset:scrollView.contentOffset];
//    }
//}
@end
