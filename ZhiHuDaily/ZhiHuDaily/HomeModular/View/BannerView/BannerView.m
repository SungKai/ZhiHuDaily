//
//  BannerView.m
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/14.
//
#define DEVICESCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define DEVICESCREENHEIGHT [[UIScreen mainScreen]bounds].size.height
#import "BannerView.h"
#import "EverydayNewsModel.h"
#import "Masonry.h"
#import "UILabel+AutoHeight.h"
#import "NSTimer+Time.h"
#import <UIImageView+AFNetworking.h>

@implementation BannerView

//重写init方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor lightGrayColor];
        self.dataArray = [[NSArray alloc]init];
        [self addSubview:self.scrollView];
    }
    return self;
}
//加载Banner
- (void)reloadBanner{
    if (self.dataArray.count != 0){
        [self showBanner];
        [self addSubview:self.pageControl];
        [self bringSubviewToFront:self.pageControl];
        [NSTimer beginWithTimer:self.timer];
    }
}
#pragma mark - 设置图片轮播
- (void)showBanner{
    for (int i = 0; i < 5; i++){
        //设置图片
        self.image = [[UIImageView alloc]init];
        self.image.frame = CGRectMake(DEVICESCREENWIDTH * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.image setImageWithURL:[NSURL URLWithString:self.dataArray[i].image] placeholderImage:[UIImage imageNamed:@"defaultImage"]];
        //title
        NSString *titleText = self.dataArray[i].title;
        UILabel *titleLab = [self creatTitleLab:titleText];
        titleLab.frame = [titleLab numberOflinesTotal:titleText AndFontOfSize:22 AndLeft:26 AndRight:28 AndTop:0 AndBottom:DEVICESCREENWIDTH - 40 AndInterval:3 AndMaxNumberOfLine:3];
        //hint
        NSString *hintText = self.dataArray[i].hint;
        UILabel *hintLab = [self creatHintLab:hintText];
        hintLab.frame = CGRectMake(26, DEVICESCREENWIDTH - 38, DEVICESCREENWIDTH - 35 - 35, 18);
        //点击图片进入新闻详情页
        [self.image setTag:i];
        NSLog(@"uuuuuuuuuu         %d", i);
        self.image.userInteractionEnabled = YES;
        //添加手势
        UITapGestureRecognizer *touchGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch:)];
        [self.image addGestureRecognizer:touchGesture];
        [self.image addSubview:titleLab];
        [self.image addSubview:hintLab];
        [self.scrollView addSubview:self.image];
    }
}
#pragma mark - 方法
//点击图片进入新闻详情页
- (void)touch:(UIGestureRecognizer *)gestureRecognizer{
    UIView *image = [gestureRecognizer view];
    NSInteger i = [image tag];
    //把ID交给HomeController
    [self.bannerDelegate deliverBannerID:self.dataArray[i].ID];
}
//创建一个title
- (UILabel *)creatTitleLab:(NSString *)text{
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.font = [UIFont boldSystemFontOfSize:22];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = text;
    return titleLab;
}
//创建一个hint
- (UILabel *)creatHintLab:(NSString *)text{
    UILabel *hintLab = [[UILabel alloc]init];
    hintLab = [[UILabel alloc]init];
    hintLab.font = [UIFont systemFontOfSize:15];
    hintLab.textColor = [UIColor colorNamed:@"214_208_203&&194_196_199"];
    hintLab.text = text;
    hintLab.frame = CGRectMake(30, DEVICESCREENWIDTH - 45, DEVICESCREENWIDTH - 35 - 35, 18);
    return hintLab;
}
#pragma mark - 懒加载
- (UIScrollView *)scrollView{
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICESCREENWIDTH, DEVICESCREENWIDTH)];
        _scrollView.bounces = NO;
//        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        //设置滚动范围
        _scrollView.contentSize = CGSizeMake(5 * DEVICESCREENWIDTH, 0);
        //分页功能
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
//pageControl
- (UIPageControl *)pageControl{
    if (!_pageControl){
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = 5;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:184/255.0 green:189/255.0 blue:171/255.0 alpha:1.0];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.frame = CGRectMake(DEVICESCREENWIDTH - 160 , DEVICESCREENWIDTH - 27, 200, 20);
    }
    return _pageControl;
}
//timer
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    }
    return _timer;
}
//image
- (UIImageView *)image{
    if (!_image){
        _image = [[UIImageView alloc]init];
    }
    return _image;
}
#pragma mark - 轮播方法
//每次循环的事件
- (void)nextPage{
    NSInteger page = self.pageControl.currentPage + 1;
    if (page == 5){
        page = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(page * DEVICESCREENWIDTH, 0) animated:YES];
    self.pageControl.currentPage = page;
}
@end
