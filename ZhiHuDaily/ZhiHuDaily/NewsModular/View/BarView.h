//
//  BarView.h
//  WKWebViewDemo
//
//  Created by 宋开开 on 2022/2/9.
//新闻额外信息，新闻详情页的底部bar
#define DEVICESCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define DEVICESCREENHEIGHT [[UIScreen mainScreen]bounds].size.height
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BarView : UIView
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *starBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UILabel *commentNumLab;
@property (nonatomic, strong) UILabel *likeNumLab;
@property (nonatomic, strong) UIView *divider;
@property (nonatomic, strong) WKWebView *webView;
//backBtn返回主界面
@property (nonatomic, copy) void(^back)(void);
//设置数据
- (void)setDataComments:(NSInteger)commentsNum AndLikeNum:(NSInteger)likeNum;
//传进来一个WebView用来展示提示框
- (void)getTheWebView:(WKWebView *)webView;
//设置尺寸
- (void)setPosition;
@end


NS_ASSUME_NONNULL_END
