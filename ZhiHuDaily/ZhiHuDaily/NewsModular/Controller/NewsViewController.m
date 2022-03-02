//
//  NewsViewController.m
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/17.
//
  
#import "NewsViewController.h"
#import "ArticleModel.h"
#import "BarView.h"
#import <WebKit/WebKit.h>
#import "Header.h"

@interface NewsViewController () <BarViewDelegate>
@property (nonatomic, strong) ArticleModel *model;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) BarView *barView;
@end

@implementation NewsViewController
//根据传进来的ID去请求并创建一个新闻详情页
- (NewsViewController *)initWithID:(NSString *)ID{
    self = [super init];
    if (self){
        ArticleModel *article = [[ArticleModel alloc]init];
        //网络请求
        //新闻内容
        [article getArticleID:ID AndModel:^(ArticleModel * _Nonnull model) {
            //加载webView
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.url]]];
        }];
        //新闻额外信息
        [article getStoryExtra:ID AndModel:^(ArticleModel * _Nonnull model) {
            [self.barView setDataComments:model.comments AndLikeNum:model.popularity];
            //把当前提示框传给barView
            [self.barView getTheWebView:self.webView];
        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"246_246_246&&153_153_153"];
    [self.view addSubview:self.webView];
    self.webView.frame = CGRectMake(0, 20, DEVICESCREENWIDTH, DEVICESCREENHEIGHT - 65);
    [self.view addSubview:self.barView];
}
#pragma mark - 懒加载
- (ArticleModel *)model{
    if (!_model){
        _model = [[ArticleModel alloc]init];
    }
    return _model;
}
- (WKWebView *)webView{
    if (!_webView){
        _webView = [[WKWebView alloc]init];
        _webView.frame = CGRectMake(0, 20, DEVICESCREENWIDTH, DEVICESCREENHEIGHT - 65);
    }
    return _webView;
}
- (BarView *)barView{
    if (!_barView){
        _barView = [[BarView alloc]init];
        _barView.barDelegate = self;
    }
    return _barView;
}
#pragma mark - <BarViewDelegate>
//返回主界面
- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
