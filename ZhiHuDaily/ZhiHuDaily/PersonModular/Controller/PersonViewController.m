//
//  PersonViewController.m
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/18.
//

#import "PersonViewController.h"
#import "LoginView.h"
@interface PersonViewController ()
@property (nonatomic, strong) LoginView *loginView;
@end

@implementation PersonViewController
//创建
- (instancetype)init{
    self = [super init];
    if (self){
        self.view.backgroundColor = [UIColor colorNamed:@"255_255_255&&26_26_26"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = self.loginView;
}
#pragma mark - 懒加载
- (LoginView *)loginView{
    if (!_loginView){
        _loginView = [[LoginView alloc]initWithLoginView];
        __weak typeof(self) weakSelf = self;
        //Block用于返回到主界面
        _loginView.back = ^{
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _loginView;
}


@end
