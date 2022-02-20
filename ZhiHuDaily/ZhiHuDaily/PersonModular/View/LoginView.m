//
//  LoginView.m
//  OthersJumpDemo
//
//  Created by 宋开开 on 2022/2/5.
//
//伪登陆的NSUserDefaults的宏定义
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]
//屏幕的宽和高
#define DEVICESCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define DEVICESCREENHEIGHT [[UIScreen mainScreen]bounds].size.height
#import "LoginView.h"
#import "Masonry.h"

@implementation LoginView
//创建
- (instancetype)initWithLoginView{
    self = [super init];
    if (self){
        self.frame = CGRectMake(0, 0, DEVICESCREENWIDTH, DEVICESCREENHEIGHT);
        //加入基本控件
        [self addSubview:self.backBtn];
        [self addSubview:self.nightVersion];
        [self addSubview:self.settingBtn];
        [self addSubview:self.basicView];
        //加入未登陆界面下的控件
        [self addViewInLogInView];
        //加入已登陆界面下的控件
        [self addViewOutLogInView];
        //为基本控件设置位置
        [self setBasicPosition];
        //为未登陆界面的控件设置位置
        [self setLogInPosition];
        //为已登陆界面的控件设置位置
        [self setLogOutPosition];
        //偏好设置
        [self userDefaults];
    }
    return self;
}
#pragma mark - 懒加载
//basicView 未登陆和已登陆都有的控件所在的View
- (UIView *)basicView{
    if (!_basicView){
        _basicView = [[UIView alloc]init];
        _basicView.frame = CGRectMake(0, 60, DEVICESCREENWIDTH, DEVICESCREENWIDTH);
    }
    return _basicView;
}
//logInView 未登陆的界面展示出来的View
- (UIView *)logInView{
    if (!_logInView){
        _logInView = [[UIView alloc]init];
        _logInView.frame = CGRectMake(0, 0, DEVICESCREENWIDTH, DEVICESCREENWIDTH);
        _logInView.backgroundColor = [UIColor colorNamed:@"255_255_255&&26_26_26"];
    }
    return _logInView;
}
//logOutView 已登陆的界面展示出来的View
- (UIView *)logOutView{
    if (!_logOutView){
        _logOutView = [[UIView alloc]init];
        _logOutView.frame = CGRectMake(0, 0, DEVICESCREENWIDTH, DEVICESCREENWIDTH);
        _logOutView.backgroundColor = [UIColor colorNamed:@"255_255_255&&26_26_26"];
    }
    return _logOutView;
}
//backBtn
- (UIButton *)backBtn{
    if (!_backBtn){
        _backBtn = [[UIButton alloc]init];
        [_backBtn setImage:[UIImage systemImageNamed:@"chevron.backward"] forState:UIControlStateNormal];
        _backBtn.tintColor = [UIColor colorNamed:@"0_0_0&154_153_154"];
        [_backBtn addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
//logInTitleLab
- (UILabel *)logInTitleLab{
    if (!_logInTitleLab){
        _logInTitleLab = [[UILabel alloc]init];
        _logInTitleLab.text = @"登陆知乎日报";
        _logInTitleLab.textAlignment = NSTextAlignmentCenter;
        _logInTitleLab.textColor = [UIColor colorNamed:@"0_0_0&154_153_154"];
        _logInTitleLab.font = [UIFont boldSystemFontOfSize:26];
    }
    return _logInTitleLab;
}
//logInWayLab
- (UILabel *)logInWayLab{
    if (!_logInWayLab){
        _logInWayLab = [[UILabel alloc]init];
        _logInWayLab.text = @"选择登陆方式";
        _logInWayLab.textAlignment = NSTextAlignmentCenter;
        _logInWayLab.textColor = [UIColor lightGrayColor];
        _logInWayLab.font = [UIFont systemFontOfSize:16];
    }
    return _logInWayLab;
}
//zhihuBtn
- (UIButton *)zhihuBtn{
    if (!_zhihuBtn){
        _zhihuBtn = [[UIButton alloc]init];
        [_zhihuBtn setBackgroundImage:[UIImage imageNamed:@"loginZhihu"] forState:UIControlStateNormal];
        [_zhihuBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zhihuBtn;
}
//WeiboBtn
- (UIButton *)WeiboBtn{
    if (!_WeiboBtn){
        _WeiboBtn = [[UIButton alloc]init];
        [_WeiboBtn setBackgroundImage:[UIImage imageNamed:@"loginWeibo"] forState:UIControlStateNormal];
        [_WeiboBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _WeiboBtn;
}
//AppleBtn
- (UIButton *)AppleBtn{
    if (!_AppleBtn){
        _AppleBtn = [[UIButton alloc]init];
        _AppleBtn.layer.cornerRadius = 25;
        _AppleBtn.backgroundColor = [UIColor colorNamed:@"0_0_0&&255_255_255"];
        [_AppleBtn setImage:[UIImage systemImageNamed:@"applelogo"] forState:UIControlStateNormal];
        _AppleBtn.imageView.tintColor = [UIColor colorNamed:@"255_255_255&&0_0_0"];
        [_AppleBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _AppleBtn;
}
//agreeBtn
- (UIButton *)agreeBtn{
    if (!_agreeBtn){
        _agreeBtn = [[UIButton alloc]init];
        [_agreeBtn setImage:[UIImage imageNamed:@"loginAgree"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"loginbtnForSure"] forState:UIControlStateSelected];
        _agreeBtn.layer.masksToBounds=YES;
        _agreeBtn.layer.cornerRadius = 10;
        //不断勾选
        [_agreeBtn addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _agreeBtn;
}
//agreeLab
- (UILabel *)agreeLab{
    if (!_agreeLab){
        _agreeLab = [[UILabel alloc]init];
        _agreeLab.text = @"我同意《知乎协议》和《个人信息保护指引》";
        _agreeLab.textAlignment = NSTextAlignmentLeft;
        _agreeLab.textColor = [UIColor lightGrayColor];
        _agreeLab.font = [UIFont systemFontOfSize:12];
    }
    return _agreeLab;
}
//personImage
- (UIImageView *)personImage{
    if (!_personImage){
        _personImage = [[UIImageView alloc]init];
        _personImage.layer.masksToBounds = YES;
        _personImage.layer.cornerRadius = 40;
        _personImage.image = [UIImage imageNamed:@"Person"];
    }
    return _personImage;
}
//nameLab
- (UILabel *)nameLab{
    if (!_nameLab){
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"宋嘉明";
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [UIFont boldSystemFontOfSize:23];
        _nameLab.textColor = [UIColor colorNamed:@"0_0_0&154_153_154"];
    }
    return _nameLab;
}
//collectLab
- (UILabel *)collectLab{
    if (!_collectLab){
        _collectLab = [[UILabel alloc]init];
        _collectLab.text = @"我的收藏";
        _collectLab.font = [UIFont systemFontOfSize:18];
        _collectLab.textColor = [UIColor colorNamed:@"26_26_26&&154_153_154"];
    }
    return _collectLab;
}
//informationLab
- (UILabel *)informationLab{
    if (!_informationLab){
        _informationLab = [[UILabel alloc]init];
        _informationLab.text = @"消息中心";
        _informationLab.font = [UIFont systemFontOfSize:18];
        _informationLab.textColor = [UIColor colorNamed:@"26_26_26&&154_153_154"];
    }
    return _informationLab;
}
//line1
- (UIView *)line1{
    if (!_line1){
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = [UIColor colorNamed:@"238_238_238&&43_43_43"];
    }
    return _line1;
}
//line2
- (UIView *)line2{
    if (!_line2){
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = [UIColor colorNamed:@"238_238_238&&43_43_43"];
    }
    return _line2;
}
//logOutBtn
- (UIButton *)logOutBtn{
    if (!_logOutBtn){
        _logOutBtn = [[UIButton alloc]init];
        [_logOutBtn setBackgroundColor:[UIColor lightGrayColor]];
        _logOutBtn.layer.masksToBounds = YES;
        _logOutBtn.layer.cornerRadius = 10;
        [_logOutBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
        [_logOutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logOutBtn;
}
//nightVersion
- (UIImageView *)nightVersion{
    if (!_nightVersion){
        _nightVersion = [[UIImageView alloc]init];
        _nightVersion.image = [UIImage imageNamed:@"light_dark"];
    }
    return _nightVersion;
}
//settingBtn
- (NightAndSettingButton *)settingBtn{
    if (!_settingBtn){
        _settingBtn = [[NightAndSettingButton alloc]init];
        [_settingBtn setImage:[UIImage imageNamed:@"loginSetting"] forState:UIControlStateNormal];
        [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
        _settingBtn.titleLabel.font = [UIFont systemFontOfSize: 16];
        _settingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_settingBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_settingBtn setTitleColor:[UIColor colorNamed:@"0_0_0&154_153_154"] forState:UIControlStateNormal];
    }
    return _settingBtn;
}
#pragma mark - 设置尺寸
//未登陆和已登陆都有的控件
- (void)setBasicPosition{
    self.frame = CGRectMake(0, 0, DEVICESCREENWIDTH, DEVICESCREENHEIGHT);
    //backBtn
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(self).offset(36);
        make.size.mas_equalTo(CGSizeMake(20, 27));
    }];
    //backBtn的image
    [self.backBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.backBtn);
    }];
    //nightVersion
    [self.nightVersion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-38);
        make.left.equalTo(self).offset(80);
        make.size.mas_equalTo(CGSizeMake(70, 75));
    }];
    //settingBtn
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-42);
        make.right.equalTo(self).offset(-80);
        make.size.mas_equalTo(CGSizeMake(70, 90));
    }];
}
//未登陆的界面展示出来的View
- (void)setLogInPosition{
    //logInTitleLab
    [self.logInTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logInView);
        make.top.equalTo(self.logInView).offset(150);
        make.size.mas_equalTo(CGSizeMake(180, 30));
    }];
    //logInWayLab
    [self.logInWayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logInView);
        make.top.equalTo(self.logInTitleLab).offset(40);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    //WeiboBtn
    [self.WeiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logInView);
        make.centerY.equalTo(self.logInWayLab).offset(70);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    //zhihuBtn
    [self.zhihuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.WeiboBtn);
        make.centerX.equalTo(self.WeiboBtn).offset(-80);
        make.size.equalTo(self.WeiboBtn);
    }];
    //AppleBtn
    [self.AppleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.WeiboBtn);
        make.centerX.equalTo(self.WeiboBtn).offset(80);
        make.size.equalTo(self.WeiboBtn);
    }];
    [self.AppleBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.AppleBtn);
        make.size.mas_equalTo(CGSizeMake(20, 24));
    }];
    //agreeBtn
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.WeiboBtn.mas_bottom).offset(20);
        make.left.equalTo(self.logInView).offset(40);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    //agreeLab
    [self.agreeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.agreeBtn);
        make.right.equalTo(self.logInView).offset(-30);
        make.left.equalTo(self.agreeBtn).offset(35);
        make.height.mas_equalTo(15);
    }];
}
//已登陆的界面展示出来的View
- (void)setLogOutPosition{
    //personImage
    [self.personImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logOutView).offset(20);
        make.centerX.equalTo(self.logOutView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    //nameLab
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personImage.mas_bottom).offset(18);
        make.centerX.equalTo(self.logOutView);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    //line1
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(DEVICESCREENWIDTH, 1));
    }];
    //collectLab
    [self.collectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logOutView).offset(20);
        make.top.equalTo(self.line1).offset(18);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    //line2
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectLab.mas_bottom).offset(18);
        make.size.mas_equalTo(self.line1);
    }];
    //informationLab
    [self.informationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectLab);
        make.top.equalTo(self.line2).offset(18);
        make.size.equalTo(self.collectLab);
    }];
    //logOutBtn
    [self.logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.informationLab).offset(80);
        make.centerX.equalTo(self.logOutView);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
}
#pragma mark - 方法
//给未登陆界面加入控件
- (void)addViewInLogInView{
    [self.logInView addSubview:self.logInTitleLab];
    [self.logInView addSubview:self.logInWayLab];
    [self.logInView addSubview:self.WeiboBtn];
    [self.logInView addSubview:self.zhihuBtn];
    [self.logInView addSubview:self.AppleBtn];
    [self.logInView addSubview:self.agreeBtn];
    [self.logInView addSubview:self.agreeLab];
}
//给已登陆界面加入控件
- (void)addViewOutLogInView{
    [self.logOutView addSubview:self.personImage];
    [self.logOutView addSubview:self.nameLab];
    [self.logOutView addSubview:self.line1];
    [self.logOutView addSubview:self.collectLab];
    [self.logOutView addSubview:self.line2];
    [self.logOutView addSubview:self.informationLab];
    [self.logOutView addSubview:self.logOutBtn];
}
//同意协议的勾选按钮
- (void)checkClick:(UIButton*)button{
    self.agreeBtn.selected = !self.agreeBtn.selected;
}
//返回按钮
- (void)backToHome{
    self.back();
}
//点击登陆
- (void)login:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected == YES){
        //已登陆状态
        [self.basicView addSubview:self.logOutView];
        //数据持久化
        [USERDEFAULTS setBool:YES forKey:@"isLogIn"];
        [USERDEFAULTS synchronize];
    }else{
        //未登陆状态
        [self.basicView addSubview:self.logInView];
        [USERDEFAULTS setBool:NO forKey:@"isLogIn"];
        [USERDEFAULTS synchronize];
    }
}
//点击退出
- (void)logout:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected == YES){
        //未登陆状态
        [self.basicView addSubview:self.logInView];
        [USERDEFAULTS setBool:NO forKey:@"isLogIn"];
        [USERDEFAULTS synchronize];
    }else{
        //已登陆状态
        [self.basicView addSubview:self.logOutView];
        //数据持久化
        [USERDEFAULTS setObject:@"Person" forKey:@"Avatar"];
        [USERDEFAULTS setBool:YES forKey:@"isLogIn"];
        [USERDEFAULTS synchronize];
    }
}
//偏好设置
- (void)userDefaults{
    //未登陆状态
    if (![USERDEFAULTS boolForKey:@"isLogIn"]){
        [self.basicView addSubview:self.logInView];
        self.zhihuBtn.selected = NO;
        self.WeiboBtn.selected = NO;
        self.AppleBtn.selected = NO;
    }else{
        //已登陆状态
        [self.basicView addSubview:self.logOutView];
        self.logOutBtn.selected = NO;
        
    }
}
@end
