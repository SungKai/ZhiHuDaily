//
//  BannerView.m
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/14.
//
  
#import "BannerView.h"
#import "EverydayNewsModel.h"
#import "Masonry.h"
#import "UILabel+AutoHeight.h"
#import "NSTimer+Time.h"
#import <UIImageView+AFNetworking.h>
#import "Header.h"
@interface BannerView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong, nullable) NSTimer *timer;
@property (nonatomic,strong) NSMutableArray<UIImageView*> *imageVArray;
@property (nonatomic,strong) UIImageView *currentImageV;
@end
@implementation BannerView
//重写init方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor lightGrayColor];
        self.dataArray = [NSArray array];
        [self addSubview:self.scrollView];
    }
    return self;
}
#pragma mark - 加载Banne 设置图片轮播
- (void)setDataArray:(NSArray<BannerModel *> *)dataArray{
    _dataArray = dataArray;
    for (UIImageView *imageV in self.imageVArray) {
        [imageV removeFromSuperview];
        self.imageVArray = [NSMutableArray array];
    }
    //取出BannerModel里面的数据遍历取出
    for (int i = 0; i < self.dataArray.count; i++){
        //设置图片
        UIImageView * image = [[UIImageView alloc]init];
        image.frame = CGRectMake(DEVICESCREENWIDTH * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [image setImageWithURL:[NSURL URLWithString:self.dataArray[i].image] placeholderImage:[UIImage imageNamed:@"defaultImage"]];
        //title
        NSString *titleText = self.dataArray[i].title;
        UILabel *titleLab = [self creatTitleLab:titleText];
        titleLab.frame = [titleLab numberOflinesTotal:titleText AndFontOfSize:22 AndLeft:26 AndRight:28 AndTop:0 AndBottom:DEVICESCREENWIDTH - 40 AndInterval:3 AndMaxNumberOfLine:3];
        //hint
        NSString *hintText = self.dataArray[i].hint;
        UILabel *hintLab = [self creatHintLab:hintText];
        hintLab.frame = CGRectMake(26, DEVICESCREENWIDTH - 38, DEVICESCREENWIDTH - 35 - 35, 18);
        //点击图片进入新闻详情页
        [image setTag:i];
        NSLog(@"uuuuuuuuuu         %d", i);
        image.userInteractionEnabled = YES;
        //添加手势
        UITapGestureRecognizer *touchGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch:)];
        [image addGestureRecognizer:touchGesture];
        [image addSubview:titleLab];
        [image addSubview:hintLab];
        [self.scrollView addSubview:image];
        [self.imageVArray addObject:image];
    }
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.currentImageV = self.imageVArray.firstObject;
    
    [self addSubview:self.pageControl];
    [self bringSubviewToFront:self.pageControl];
    if (!self.timer) {
        __weak typeof(self) weakSelf = self;
        self.timer = [NSTimer timerWithTimeInterval:5.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (weakSelf) {
                [weakSelf nextPage];
            }
        }];
    }
    [NSTimer beginWithTimer:self.timer];
}

- (void)showBanner{
    
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
//判断是否正在滚动
- (void)setIsScrolling:(BOOL)isScrolling{
    _isScrolling = isScrolling;
    //不加会异常：NStimer beginWithTimer
    if (!self.timer) {
        return;
    }
    if (isScrolling) {
        [self.timer end];
        self.timer = nil;
    }else{
        //缩放效果
        [NSTimer beginWithTimer:self.timer];
        if (self.currentImageV) {
            self.currentImageV.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
    }
}
//设置缩放效果
- (void)setOffsetY:(CGFloat)offsetY{
    if (self.currentImageV) {
        if (offsetY >= 0) {
            self.currentImageV.transform = CGAffineTransformMakeScale(1, 1);
        }else {
            float scale = fabs(offsetY)/200.0 + 1;
            self.currentImageV.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
}

- (NSInteger)currentPage {
    return self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView{
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICESCREENWIDTH, DEVICESCREENWIDTH)];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        //设置滚动范围
        _scrollView.contentSize = CGSizeMake(5 * DEVICESCREENWIDTH, 0);
        //分页功能
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
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
#pragma mark - 轮播方法
//每次循环的事件
- (void)nextPage{
    if (self.dataArray.count == 0 || self.imageVArray.count == 0) {
        return;
    }
    NSInteger page = self.pageControl.currentPage + 1;
    if (page == self.dataArray.count){
        page = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(page * DEVICESCREENWIDTH, 0) animated:YES];
    self.pageControl.currentPage = page;
    self.currentImageV = self.imageVArray[page];
}

#pragma mark - <UIScrollViewDelegate>
//监听滚动状态来使pageControl也作出相应变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算页码(四舍五入）
    int page = (int)(scrollView.contentOffset.x / DEVICESCREENWIDTH + 0.5);
    self.pageControl.currentPage = page;
    //(当只有一页时隐藏）
    self.pageControl.hidesForSinglePage = YES;
    self.currentImageV = self.imageVArray[page];
}
- (NSMutableArray<UIImageView *> *)imageVArray{
    if (!_imageVArray) {
        _imageVArray = [NSMutableArray array];
    }
    return _imageVArray;
}
- (void)dealloc{
    if (self.timer) {
        [self.timer end];
        self.timer = nil;
    }
}
@end
