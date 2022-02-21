//
//  TopView.m
//  AFN_MJDemo
//
//  Created by 宋开开 on 2022/2/4.
//
//偏好设置的宏定义
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]
//屏幕的宽和长
#define DEVICESCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define DEVICESCREENHEIGHT [[UIScreen mainScreen]bounds].size.height
#import "TopView.h"
#import "Masonry.h"
@implementation TopView
- (instancetype)initWithTop{
    self = [super init];
    if (self){
        self.backgroundColor = [UIColor colorNamed:@"255_255_255&26_26_26"];
        //设置时间
        [self addSubview:self.personButton];
        //单击TopView回到顶部
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upToTop)];
        [self addGestureRecognizer:tap];
        [self addSubview:self.dayLab];
        [self addSubview:self.monthLab];
        [self addSubview:self.mainTitle];
        [self addSubview:self.divider];
        //设置尺寸
        [self setPosition];
    }
    return self;
}
#pragma mark - 方法
//单击TopView回到顶部
- (void)upToTop{
    [self.topDelegate topTap];
}
#pragma mark - 懒加载
//dayLab
- (UILabel *)dayLab{
    if (!_dayLab){
        _dayLab = [[UILabel alloc]init];
        _dayLab.textAlignment = NSTextAlignmentCenter;
        _dayLab.font = [UIFont boldSystemFontOfSize:20];
        _dayLab.textColor = [UIColor colorNamed:@"68_68_68&129_129_129"];
        //计算时间
        NSDate *date =[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"d";
        NSString *day = [formatter stringFromDate:date];
        _dayLab.text = day;
    }
    return _dayLab;
}
//monthLab
- (UILabel *)monthLab{
    if (!_monthLab){
        _monthLab = [[UILabel alloc]init];
        _monthLab.font = [UIFont systemFontOfSize:13];
        _monthLab.textAlignment = NSTextAlignmentCenter;
        _monthLab.textColor = [UIColor colorNamed:@"68_68_68&129_129_129"];
        //计算时间
        NSDate *date =[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"M";
        NSString *month = [formatter stringFromDate:date];
        _monthLab.text = [self transformMonth:month];
    }
    return _monthLab;
}
//divider
- (UIView *)divider{
    if (!_divider){
        _divider = [[UIView alloc]init];
        _divider.backgroundColor = [UIColor lightGrayColor];
    }
    return _divider;
}
//personButton
- (UIButton *)personButton{
    if (!_personButton){
        _personButton = [[UIButton alloc]init];
        _personButton.layer.masksToBounds = YES;
        _personButton.layer.cornerRadius = 19;
        [_personButton setBackgroundImage:[UIImage imageNamed:[self judgeTheAvatar]] forState:UIControlStateNormal];
        [_personButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _personButton;
}
//mainTitle
- (UILabel *)mainTitle{
    if (!_mainTitle){
        _mainTitle = [[UILabel alloc]init];
        _mainTitle.text = @"知乎日报";
        _mainTitle.textColor = [UIColor colorNamed:@"0_0_0&154_153_154"];
        _mainTitle.textAlignment = NSTextAlignmentLeft;
        _mainTitle.font = [UIFont boldSystemFontOfSize:24];
    }
    return _mainTitle;
}
//把月份的数字转换为文字
- (NSString *)transformMonth:(NSString *)month{
    //设置数字数组
    NSArray *numberArray = @[@"1", @"2",@"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    NSArray *stringArray = @[@"一月", @"二月",@"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:stringArray forKeys:numberArray];
    return [dict objectForKey:month];
}
//设置尺寸
- (void)setPosition{
    self.frame = CGRectMake(0, 0, DEVICESCREENWIDTH, 85);
    //monthLab
    [self.monthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-6);
        make.left.equalTo(self).offset(12);
        make.size.mas_equalTo(CGSizeMake(35, 15));
    }];
    //dayLab
    [self.dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.monthLab.mas_top).offset(-3);
        make.centerX.equalTo(self.monthLab);
        make.left.right.equalTo(self.monthLab);
        make.height.mas_equalTo(17);
    }];
    //divider
    [self.divider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.bottom.equalTo(self.monthLab).offset(1);
        make.top.equalTo(self.dayLab).offset(-2);
        make.left.equalTo(self.monthLab.mas_right).offset(10);
    }];
    //mainTitle
    [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.divider).offset(12);
//        make.bottom.equalTo(self).offset(20);
        make.centerY.equalTo(self.divider);
        make.size.mas_equalTo(CGSizeMake(110, 30));
    }];
    //personButton
    [self.personButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.divider);
        make.right.equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
}
//跳转到登陆页
- (void)login{
    //跳转
    [self.topDelegate loginView];
}
//判断是否已经登陆
- (NSString *)judgeTheAvatar{
    //偏好设置
    //已登陆
    if ([USERDEFAULTS boolForKey:@"isLogIn"]){
        return @"Person";
    }else{
        return @"Account_Avatar";
    }
}
//登陆后再加载
- (void)reloadData{
    [self.personButton setBackgroundImage:[UIImage imageNamed:[self judgeTheAvatar]] forState:UIControlStateNormal];
}
@end
