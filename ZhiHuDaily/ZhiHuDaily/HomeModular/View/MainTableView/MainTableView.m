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
@interface MainTableView ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

@end
@implementation MainTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self){
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.everydayNews = [NSMutableArray array];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}


#pragma mark - <UITableViewDataSourse>
//行数section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.everydayNews.count;
}
//每行的cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.everydayNews[section].stories.count;
}
//每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置无数据状态
    NewsCell *newsCell = [NewsCell creatCellDefault:tableView];
    //取出Model里面的数据，把相应数据给相应cell
    DataModel *dataModel = self.everydayNews[indexPath.section].stories[indexPath.row];
    
    return  [newsCell cellWithInformation:newsCell WithTitleText:dataModel.title WithHintText:dataModel.hint WithImageURL:dataModel.imageURL];
}

#pragma mark - <UITableViewDelegate>
//每当拉到每个section的FooterView就加载Before数据
- (void)tableView:(UITableView *)tableView
willDisplayFooterView:(nonnull UIView *)view forSection:(NSInteger)section{
    if (self.everydayNews.count == section + 1){
        [self.mainDelegate nextSectionBlock:section];
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
    NSString *date = self.everydayNews[section].date;
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
    [self.mainDelegate gainIndexPath:indexPath];
}

//即将开始拖拽时停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    这个方法实现了，那么就去调用，防止出现异常
    if ([self.mainDelegate respondsToSelector:@selector(scrollViewWithIsScrolling:offsetY:)]) {
        [self.mainDelegate scrollViewWithIsScrolling:YES offsetY:0];
    }
}

//已经停止拖拽时开启计时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self.mainDelegate respondsToSelector:@selector(scrollViewWithIsScrolling:offsetY:)]) {
        [self.mainDelegate scrollViewWithIsScrolling:NO offsetY:0];
    }
}
#pragma mark - 滚动放大
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.mainDelegate respondsToSelector:@selector(scrollViewWithIsScrolling:offsetY:)]) {
        [self.mainDelegate scrollViewWithIsScrolling:YES offsetY:scrollView.contentOffset.y];
    }
}
@end
