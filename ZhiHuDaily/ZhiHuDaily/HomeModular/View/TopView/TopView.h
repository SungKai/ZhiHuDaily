//
//  TopView.h
//  AFN_MJDemo
//
//  Created by 宋开开 on 2022/2/4.
//
//此类为顶部的TopView，用于展示今日日期与进入个人界面
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//代理
@protocol TopViewDelegate <NSObject>
@required
//点击topView回到顶部
- (void)topTap;
//点击头像进入个人登陆页
- (void)loginView;
@end
@interface TopView : UIView
//代理
@property (nonatomic, weak) id <TopViewDelegate> topDelegate;
@property (nonatomic, strong) UILabel *dayLab;
@property (nonatomic, strong) UILabel *monthLab;
@property (nonatomic, strong) UIView *divider;
@property (nonatomic, strong) UILabel *mainTitle;
@property (nonatomic, strong) UIButton *personButton;
//初始化
- (instancetype)initWithTop;
//设置尺寸
- (void)setPosition;
//登陆后再加载,保存偏好设置
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
