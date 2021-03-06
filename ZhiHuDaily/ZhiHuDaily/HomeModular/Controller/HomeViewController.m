//
//  HomeViewController.m
//  ZhihuDemoAFN_MJ
//
//  Created by 宋开开 on 2022/2/2.
//

#import "HomeViewController.h"
#import "TopView.h"
#import "BannerView.h"
#import "MainTableView.h"
#import "EverydayNewsModel.h"
#import "DataModel.h"
#import <UIImageView+AFNetworking.h>
#import "NSTimer+Time.h"

@interface HomeViewController ()<BannerDelegate, MainTableDelegate, UIScrollViewDelegate,TopViewDelegate>
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
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    //登陆后再次启动会刷新头像
    [self.topView reloadData];
    [self.view addSubview:self.mainTableView];
    //下拉刷新
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.mainTableView.refreshControl = control;
    // MVC：加载最新数据并从Model里面拿到数据转交给BannerView和MainTableView
    [self loadNewData];
}
//刷新，使登陆或退出后点击返回主界面时TopView的头像作出对应变化
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.topView reloadData];
}
#pragma mark - 懒加载
- (EverydayNewsModel *)everydayModel{
    if (!_everydayModel){
        _everydayModel = [[EverydayNewsModel<UITableViewDataSource> alloc]init];
    }
    return _everydayModel;
}
- (TopView *)topView{
    if (!_topView){
        _topView = [[TopView alloc]initWithTop];
        _topView.topDelegate = self;
    }
    return _topView;
}
- (MainTableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[MainTableView alloc]initWithFrame:CGRectMake(0, 85, DEVICESCREENWIDTH, DEVICESCREENHEIGHT - 85) style:UITableViewStyleGrouped];
        _mainTableView.mainDelegate = self;
        _mainTableView.backgroundColor = [UIColor colorNamed:@"255_255_255&26_26_26"];
        //把bannerView作为mainTableView的tableHeaderView
        _mainTableView.tableHeaderView = self.bannerView;
    }
    return _mainTableView;
}
- (BannerView *)bannerView{
    if (!_bannerView){
        _bannerView = [[BannerView alloc]initWithFrame:CGRectMake(0, 0, DEVICESCREENWIDTH, DEVICESCREENWIDTH)];
        _bannerView.bannerDelegate = self;
    }
    return _bannerView;
}
#pragma mark - 方法
//下拉刷新
- (void)refreshTableView{
    [self loadNewData];
}
//加载最新数据
- (void)loadNewData{
    __weak typeof(self) weakSelf = self;
    //Latest网络请求
    [self.everydayModel gainLatestData:^{
        //1.判断是否正在下拉刷新状态，若是正在刷新，则停止刷新
        if ([self.mainTableView.refreshControl isRefreshing]){
            [self.mainTableView.refreshControl endRefreshing];
        }
        //2.把加载来的数据传递到banner的model里面，
        NSMutableArray<BannerModel *> *bannerModelArray = [NSMutableArray array];
        for (int i = 0; i < weakSelf.everydayModel.everydayNews[0].top_stories.count; i++) {
            //从Model里面拿到数据
            DataModel *dataModel = weakSelf.everydayModel.everydayNews[0].top_stories[i];
            //交给BannerView里面的BannerView
            BannerModel *bannerModel =[[BannerModel alloc]initWithImage:dataModel.image title:dataModel.title hint:dataModel.hint ID:dataModel.ID];
            [bannerModelArray addObject:bannerModel];
        }
        //重写set方法传递banner数据
        weakSelf.bannerView.dataArray = bannerModelArray;
        //3.主页tableView数据传递
        weakSelf.mainTableView.everydayNews = weakSelf.everydayModel.everydayNews;
        //刷新cell
        [weakSelf.mainTableView reloadData];
    }];
}
//传递滚动数据
- (void)scrollViewWithIsScrolling:(BOOL)isScrolling offsetY:(CGFloat)offsetY{
    self.bannerView.isScrolling = isScrolling;
    self.bannerView.offsetY = offsetY;
}

#pragma mark - <BannerDelegate>
//界面跳转:Banner跳转新闻详情页
- (void)deliverBannerID:(NSString *)ID{
    //实行跳转的操作应该是有Controller进行，传ID给ManagerConreoller
    UIViewController *newsController = [self.homeDelegate deliverTheID:ID];
    //界面跳转
    [self.navigationController pushViewController:newsController animated:YES];
}
#pragma mark - <TopViewDelegate>
//点击topView回到顶部
- (void)topTap{
    [self.mainTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
//跳转登陆页
- (void)loginView{
    [self.navigationController pushViewController:[self.homeDelegate jumpToLogin] animated:YES];
}
#pragma mark - <MainTableDelegate>
//进新闻详情页,点击cell,把indexPath传给HomeViewController来进行页面跳转,根据传进来的indexPath找到相应的文章ID
- (void)gainIndexPath:(NSIndexPath *)indexPath{
    //实行跳转的操作应该是有Controller进行，由传进来的indexPath取出model里面的ID，再传ID给ManagerConreoller
    NSString *ID = self.everydayModel.everydayNews[indexPath.section].stories[indexPath.row].ID;
    NSLog(@"dsdsdsdsdsdsd    %@", ID);
    UIViewController *newsController = [self.homeDelegate deliverTheID:ID];
    //界面跳转
    [self.navigationController pushViewController:newsController animated:YES];
}
//当下滑到每一组最后一个cell时，调用此方法来网络请求前一天的数据
- (void)nextSectionBlock:(NSInteger)section{
    //加载多次，存在循环引用
    __weak typeof(self) weakSelf = self;
    [self.everydayModel gainBeforeDataAndDate:self.everydayModel.everydayNews.lastObject.date And:^{
        //再次传递数据给mainTableView让其展示数据
        weakSelf.mainTableView.everydayNews = weakSelf.everydayModel.everydayNews;
        //mainTableView再次刷新
        [self.mainTableView reloadData];
    }];
}
//传递日期给dateView
- (NSString *)gainDate:(NSInteger)section{
    return self.everydayModel.everydayNews[section].date;
}
@end
