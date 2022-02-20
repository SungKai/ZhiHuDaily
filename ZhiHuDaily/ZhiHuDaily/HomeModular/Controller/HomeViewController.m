//
//  HomeViewController.m
//  ZhihuDemoAFN_MJ
//
//  Created by 宋开开 on 2022/2/2.
//

#define DEVICESCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define DEVICESCREENHEIGHT [[UIScreen mainScreen]bounds].size.height
#import "HomeViewController.h"
#import "TopView.h"
#import "BannerView.h"
#import "MainTableView.h"
#import "EverydayNewsModel.h"
#import "DataModel.h"
#import <UIImageView+AFNetworking.h>
#import "NSTimer+Time.h"

@interface HomeViewController ()<SourseNewsDelegate, UITableViewDelegate, BannerDelegate, MainTableDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) TopView *topView;
@property (nonatomic, strong) BannerView *bannerView;
@property (nonatomic, strong) MainTableView *mainTableView;
@property (nonatomic, strong) EverydayNewsModel<UITableViewDataSource> *everydayModel;
@end

@implementation HomeViewController
- (instancetype)init{
    self = [super init];
    if (self){
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    //登陆后再次启动会刷新头像
    [self.topView reloadData];
    [self.view addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = self.bannerView;
    [self.everydayModel gainLatestData:^{
        NSLog(@"latest             self.mainTableView reloadData");
        [self.mainTableView reloadData];
        self.bannerView.dataArray = self.everydayModel.everydayNews[0].top_stories;
        NSLog(@"aaaaaaaa        %@", self.everydayModel.everydayNews[0].top_stories[1].title);
        [self.bannerView reloadBanner];
    }];
    //下拉刷新
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.mainTableView.refreshControl = control;
    
}
//刷新，使登陆或退出后点击返回主界面时TopView的头像作出对应变
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.topView reloadData];
}
#pragma mark - 懒加载
- (EverydayNewsModel *)everydayModel{
    if (!_everydayModel){
        _everydayModel = [[EverydayNewsModel<UITableViewDataSource> alloc]init];
        _everydayModel.sourseNewsDelegate = self;
    }
    return _everydayModel;
}
- (TopView *)topView{
    if (!_topView){
        _topView = [[TopView alloc]initWithTop];
        __weak typeof(self) weakSelf_top= self;
        _topView.topTap = ^{
            [weakSelf_top.mainTableView setContentOffset:CGPointMake(0, 0) animated:YES];
        };
        //界面跳转到个人登陆页
        __weak typeof(self) weakSelf_logIn= self;
        _topView.loginView = ^{
            [weakSelf_logIn.navigationController pushViewController:[weakSelf_logIn.homeDelegate jumpToLogin] animated:YES];
        };
    }
    return _topView;
}
- (MainTableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[MainTableView alloc]initWithFrame:CGRectMake(0, 85, DEVICESCREENWIDTH, DEVICESCREENHEIGHT - 85) style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self.everydayModel;
        _mainTableView.mainDelegate = self;
        _mainTableView.backgroundColor = [UIColor colorNamed:@"255_255_255&26_26_26"];
        _mainTableView.everydayModel = self.everydayModel;
        //Block传递过往请求的section
        __weak typeof(self) weakSelf_before = self;
        _mainTableView.nextSectionBlock = ^(NSInteger section) {
            [weakSelf_before nextSection:section];
        };
        //Block传递日期给dateView
        __weak typeof(self) weakSelf_date = self;
        _mainTableView.gainDate = ^NSString * _Nonnull(NSInteger section) {
                return weakSelf_date.everydayModel.everydayNews[section].date;
        };
        //Block把cell的indexPath通过代理传递给管理者ManagerViewController跳转进新闻详情页
        __weak typeof(self) weakSelf_article = self;
        _mainTableView.deliverTheIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
            [weakSelf_article deliverTheIndexPath:indexPath];
        };
    }
    return _mainTableView;
}
- (BannerView *)bannerView{
    if (!_bannerView){
        _bannerView = [[BannerView alloc]initWithFrame:CGRectMake(0, 0, DEVICESCREENWIDTH, DEVICESCREENWIDTH)];
        _bannerView.dataSource = self.everydayModel;
        _bannerView.bannerDelegate = self;
        _bannerView.scrollerView.delegate = self;
    }
    return _bannerView;
}
#pragma mark - 方法
//下拉刷新
- (void)refreshTableView{
    //延迟1s执行，否则正在刷新时新cell已经显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新后新增cell
        [self.mainTableView reloadData];
        //判断是否正在下拉刷新状态，若是 停止刷新
        if ([self.mainTableView.refreshControl isRefreshing]) {
            [self.mainTableView.refreshControl endRefreshing];
        }
    });
}
//当下滑到每一组最后一个cell时，调用此方法来网络请求前一天的数据
- (void)nextSection:(NSInteger)section{
    [self.everydayModel gainBeforeDataAndDate:self.everydayModel.everydayNews.lastObject.date And:^{
        NSLog(@"self.mainTableView reloadData");
        [self.mainTableView reloadData];
    }];
}
//进新闻详情页,根据传进来的indexPath找到相应的文章ID
- (void)deliverTheIndexPath:(NSIndexPath *)indexPath{
    //实行跳转的操作应该是有Controller进行，由传进来的indexPath取出model里面的ID，再传ID给ManagerConreoller
    NSString *ID = self.everydayModel.everydayNews[indexPath.section].stories[indexPath.row].ID;
    NSLog(@"dsdsdsdsdsdsd    %@", ID);
    UIViewController *newsController = [self.homeDelegate deliverTheID:ID];
    //界面跳转
    [self.navigationController pushViewController:newsController animated:YES];
}

#pragma mark - <SourseNewsDelegate>
//根据dataModel创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView SourseNewsForSourse:(DataModel *)dataModel{
    if (dataModel == nil){
        //无数据状态
        return [self.mainTableView creatFromTableView:tableView];
    }else{
        NewsCell *newsCell = [self.mainTableView creatFromTableView:tableView];
        return [newsCell cellWithInformation:newsCell WithTitleText:dataModel.title WithHintText:dataModel.hint WithImageURL:dataModel.imageURL];
    }
}

#pragma mark - <UIScrollViewDelegate>
//监听滚动状态来使pageControl也作出相应变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算页码(四舍五入）
    int page = (int)(scrollView.contentOffset.x / DEVICESCREENWIDTH + 0.5);
    self.bannerView.pageControl.currentPage = page;
    //(当只有一页时隐藏）
    self.bannerView.pageControl.hidesForSinglePage = YES;
}

//即将开始拖拽时停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.bannerView.timer end];
    self.bannerView.timer = nil;
}

//已经停止拖拽时开启计时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [NSTimer beginWithTimer:self.bannerView.timer];
}
#pragma mark - <BannerDelegate>
//界面跳转:Banne跳转新闻详情页
- (void)deliverBannerID:(NSString *)ID{
    //实行跳转的操作应该是有Controller进行，传ID给ManagerConreoller
    UIViewController *newsController = [self.homeDelegate deliverTheID:ID];
    //界面跳转
    [self.navigationController pushViewController:newsController animated:YES];
}
#pragma mark - MainTableDelegate
//banner拉伸放大功能
- (void)bannerOffset:(CGPoint)offset{
//    BannerView *banner = self.bannerView;
//    CGRect rect = self.bannerView.scrollerView.frame;
//    rect.origin.y = offset.y;
//    rect.origin.x = offset.x;
//    NSLog(@"ppppppppp           %f", rect.origin.y);
//    rect.size.height = DEVICESCREENWIDTH - offset.y;
//    NSLog(@"sssssssss           %f", rect.size.height);
//
////    self.bannerView.frame = rect;
//    self.bannerView.scrollerView.frame = rect;
//    self.mainTableView.tableHeaderView.frame = rect;
//    self.bannerView.image.frame = rect;
//    self.bannerView.image.frame = self.bannerView.scrollerView.frame;
}


@end
