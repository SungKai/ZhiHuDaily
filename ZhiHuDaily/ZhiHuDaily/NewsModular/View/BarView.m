////
//  BarView.m
//  WKWebViewDemo
//
//  Created by 宋开开 on 2022/2/9.
//

#import "BarView.h"
#import "Masonry.h"
#import "PopAlterView.h"
#import "Header.h"
@implementation BarView
- (instancetype)init{
    self = [super init];
    if (self){
        self.backgroundColor = [UIColor colorNamed:@"246_246_246&&153_153_153"];
        [self addSubview:self.backBtn];
        [self addSubview:self.divider];
        [self addSubview:self.commentBtn];
        [self addSubview:self.commentNumLab];
        [self addSubview:self.likeBtn];
        [self addSubview:self.likeNumLab];
        [self addSubview:self.starBtn];
        [self addSubview:self.shareBtn];
        [self setPosition];
    }
    return self;
}
#pragma mark - 懒加载
//backBtn
- (UIButton *)backBtn{
    if (!_backBtn){
        _backBtn = [[UIButton alloc]init];
        [_backBtn setImage:[UIImage systemImageNamed:@"chevron.backward"] forState:UIControlStateNormal];
        _backBtn.imageView.tintColor = [UIColor colorNamed:@"0_0_0&&153_153_153"];
        [_backBtn addTarget:self action:@selector(backToHomeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
//divider
- (UIView *)divider{
    if (!_divider){
        _divider = [[UIView alloc]init];
        _divider.backgroundColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1.0];
    }
    return _divider;
}
//commentBtn
- (UIButton *)commentBtn{
    if (!_commentBtn){
        _commentBtn = [[UIButton alloc]init];
        [_commentBtn setImage: [UIImage systemImageNamed:@"bubble.middle.bottom"] forState:UIControlStateNormal];
        _commentBtn.imageView.tintColor = [UIColor colorNamed:@"0_0_0&&153_153_153"];
        
    }
    return _commentBtn;
}
//commentNumLab
- (UILabel *)commentNumLab{
    if (!_commentNumLab){
        _commentNumLab = [[UILabel alloc]init];
        _commentNumLab.textColor = [UIColor colorNamed:@"0_0_0&&153_153_153"];
        _commentNumLab.font = [UIFont systemFontOfSize:10];
    }
    return _commentNumLab;
}
//likeBtn
- (UIButton *)likeBtn{
    if (!_likeBtn){
        _likeBtn = [[UIButton alloc]init];
        [_likeBtn setImage: [UIImage systemImageNamed:@"hand.thumbsup"] forState:UIControlStateNormal];
        [_likeBtn setImage: [UIImage systemImageNamed:@"hand.thumbsup.fill"] forState:UIControlStateSelected];
        _likeBtn.tintColor = [UIColor colorNamed:@"0_0_0&&153_153_153"];
        [_likeBtn addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}
//likeNumLab
- (UILabel *)likeNumLab{
    if (!_likeNumLab){
        _likeNumLab = [[UILabel alloc]init];
        _likeNumLab.textColor = [UIColor colorNamed:@"0_0_0&&153_153_153"];
        _likeNumLab.font = [UIFont systemFontOfSize:10];
    }
    return _likeNumLab;
}
//starBtn
- (UIButton *)starBtn{
    if (!_starBtn){
        _starBtn = [[UIButton alloc]init];
        [_starBtn setImage:[UIImage systemImageNamed:@"star"] forState:UIControlStateNormal];
        [_starBtn setImage:[UIImage systemImageNamed:@"star.fill"] forState:UIControlStateSelected];
        _starBtn.tintColor = [UIColor colorNamed:@"0_0_0&&153_153_153"];
        [_starBtn addTarget:self action:@selector(starClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _starBtn;
}
//shareBtn
- (UIButton *)shareBtn{
    if (!_shareBtn){
        _shareBtn = [[UIButton alloc]init];
        [_shareBtn setImage:[UIImage systemImageNamed:@"square.and.arrow.up"] forState:UIControlStateNormal];
        _shareBtn.tintColor = [UIColor colorNamed:@"0_0_0&&153_153_153"];
    }
    return _shareBtn;
}
//webView
- (WKWebView *)webView{
    if (!_webView){
        _webView = [[WKWebView alloc]init];
    }
    return _webView;
}
#pragma mark - 方法
//设置数据
- (void)setDataComments:(NSInteger)commentsNum AndLikeNum:(NSInteger)likeNum{
    self.commentNumLab.text = @"24";
    self.commentNumLab.text = [NSString stringWithFormat:@"%ld", commentsNum];
    self.likeNumLab.text = [NSString stringWithFormat:@"%ld", likeNum];
}
//拿到webView
- (void)getTheWebView:(WKWebView *)webView{
    self.webView = webView;
}

//返回主界面
- (void)backToHomeView{
    [self.barDelegate back];
}
//点赞的事件
- (void)likeClick:(UIButton*)button{
    button.tintColor = [UIColor colorWithRed:8/255.0 green:156/255.0 blue:227/255.0 alpha:1.0];
    int num = [self.likeNumLab.text intValue] + 1;
    self.likeNumLab.text = [NSString stringWithFormat:@"%d", num];
    button.selected = !button.selected;
    //取消选中状态
    if (!button.selected){
        button.tintColor = [UIColor colorNamed:@"0_0_0&&153_153_153"];
        int num = [self.likeNumLab.text intValue] - 2;
        self.likeNumLab.text = [NSString stringWithFormat:@"%d", num];
        //提示框
        PopAlterView *popView = [[PopAlterView alloc]initWithPopAlterViewTheText:@"已取消点赞"];
        [popView showThePopAlterView:self.webView];
        //选中状态
    }else{
        //提示框
        PopAlterView *popView = [[PopAlterView alloc]initWithPopAlterViewTheText:@"已点赞"];
        [popView showThePopAlterView:self.webView];
    }
}
//收藏事件
- (void)starClick:(UIButton*)button{
    button.tintColor = [UIColor colorWithRed:8/255.0 green:156/255.0 blue:227/255.0 alpha:1.0];
    button.selected = !button.selected;
    ////取消选中状态
    if (!button.selected){
        button.tintColor = [UIColor colorNamed:@"0_0_0&&153_153_153"];
        //提示框
        PopAlterView *popView = [[PopAlterView alloc]initWithPopAlterViewTheText:@"已取消收藏"];
        [popView showThePopAlterView:self.webView];
        //选中状态
    }else{
        //提示框
        PopAlterView *popView = [[PopAlterView alloc]initWithPopAlterViewTheText:@"已收藏"];
        [popView showThePopAlterView:self.webView];
    }
}
#pragma mark - 设置尺寸
- (void)setPosition{
    self.frame = CGRectMake(0, DEVICESCREENHEIGHT - 50, DEVICESCREENWIDTH, 50);
    //backBtn
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.size.mas_equalTo(CGSizeMake(18, 26));
    }];
    //backBtn的image
    [self.backBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.backBtn);
    }];
    //divider
    [self.divider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(self.backBtn).offset(3);
        make.top.equalTo(self.backBtn).offset(-3);
        make.left.equalTo(self.backBtn.mas_right).offset(23);
    }];
    //likeBtn
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    //likeBtn的image
    [self.likeBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.likeBtn);
    }];
    //likeNumLab
    [self.likeNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 10));
        make.left.equalTo(self.likeBtn.mas_right).offset(1);
        make.top.equalTo(self.likeBtn).offset(-2);
    }];
    //commentBtn
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.likeBtn.mas_left).offset(-60);
        make.size.mas_equalTo(self.likeBtn);
    }];
    //commentBtn的的image
    [self.commentBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.commentBtn);
    }];
    //commentNumLab
    [self.commentNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.likeNumLab);
        make.left.equalTo(self.commentBtn.mas_right).offset(1);
        make.top.equalTo(self.commentBtn).offset(-2);
    }];
    //starBtn
    [self.starBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.likeBtn.mas_right).offset(62);
        make.size.equalTo(self.commentBtn);
    }];
    //starBtn的image
    [self.starBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.starBtn);
    }];
    //shareBtn
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-30);
        make.size.mas_equalTo(self.likeBtn);
    }];
    //shareBtn的image
    [self.shareBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.likeBtn);
    }];
}



@end
