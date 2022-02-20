//
//  TopView.h
//  AFN_MJDemo
//
//  Created by 宋开开 on 2022/2/4.
//
//此类为顶部的TopView
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopView : UIView
@property (nonatomic, strong) UILabel *dayLab;
@property (nonatomic, strong) UILabel *monthLab;
@property (nonatomic, strong) UIView *divider;
@property (nonatomic, strong) UILabel *mainTitle;
@property (nonatomic, strong) UIButton *personButton;
@property (nonatomic, assign) NSDateComponents *dateCom;
@property (nonatomic, copy) NSString *monthText;
//点击topView回到顶部
@property (nonatomic, copy) void(^topTap)(void);
//点击头像进入个人登陆页
@property (nonatomic, copy) void(^ loginView)(void);
- (instancetype)initWithTop;
//设置尺寸
- (void)setPosition;
//计算时间
- (void)calculateTime;
//把月份的数字转换为文字
- (void)transformMonth;
//登陆后再加载,保存偏好设置
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
