//
//  LoginView.h
//  OthersJumpDemo
// 
//  Created by 宋开开 on 2022/2/5.
//
//此类有登陆和退出两种View
#import <UIKit/UIKit.h>
#import "NightAndSettingButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIView *logInView;
@property (nonatomic, strong) UIView *logOutView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *logInTitleLab;
@property (nonatomic, strong) UILabel *logInWayLab;
@property (nonatomic, strong) UILabel *agreeLab;
@property (nonatomic, strong) UIButton *zhihuBtn;
@property (nonatomic, strong) UIButton *WeiboBtn;
@property (nonatomic, strong) UIButton *AppleBtn;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, strong) UIImageView *personImage;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *collectLab;
@property (nonatomic, strong) UILabel *informationLab;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIButton *logOutBtn;
@property (nonatomic, strong) UIImageView *nightVersion;
//自定义Button，右下角的设置按钮
@property (nonatomic, strong) NightAndSettingButton *settingBtn;
//backBtn返回主界面
@property (nonatomic, copy) void(^back)(void);
//创建
- (instancetype)initWithLoginView;
//重复点击button（勾选）
- (void)checkClick:(UIButton*)button;
@end

NS_ASSUME_NONNULL_END
