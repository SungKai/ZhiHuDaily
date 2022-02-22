//
//  BarView.h
//  WKWebViewDemo
//
//  Created by 宋开开 on 2022/2/9.
//新闻额外信息，新闻详情页的底部bar
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN
//代理
@protocol BarViewDelegate <NSObject>
@required
//返回主界面
- (void)back;
@end

@interface BarView : UIView
//代理
@property (nonatomic, strong) id <BarViewDelegate> barDelegate;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *starBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UILabel *commentNumLab;
@property (nonatomic, strong) UILabel *likeNumLab;
@property (nonatomic, strong) UIView *divider;
@property (nonatomic, strong) WKWebView *webView;
//设置数据
- (void)setDataComments:(NSInteger)commentsNum AndLikeNum:(NSInteger)likeNum;
//传进来一个WebView用来展示提示框
- (void)getTheWebView:(WKWebView *)webView;
//设置尺寸
- (void)setPosition;
@end


NS_ASSUME_NONNULL_END
