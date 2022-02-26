//
//  PopAlterView.m
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/19.
//
  
#import "PopAlterView.h"
#import "Masonry.h"
#import "Header.h"
@interface PopAlterView()
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *image;
@end
@implementation PopAlterView
//创建
- (instancetype)initWithPopAlterViewTheText:(NSString *)text{
    self = [super init];
    if (self){
        [self addSubview:self.popView];
        [self.popView addSubview:self.titleLab];
        [self.popView addSubview:self.image];
        self.titleLab.text = text;
        //计算文字宽度
        CGFloat width = [self calculateTheWidth:text];
        //设置位置
        [self setPosition:width];
    }
    return self;
}
//展示提示框
- (void)showThePopAlterView:(UIView *)view{
    [view addSubview:self.popView];
    //1s后消失
    [self performSelector:@selector(hideDelayed)withObject:[NSNumber numberWithBool:YES]afterDelay:1.0];
}
//自动消失
- (void)hideDelayed{
    [self.popView removeFromSuperview];
}
#pragma mark - 懒加载
//popView
- (UIView *)popView{
    if (!_popView){
        _popView = [[UIView alloc]init];
        _popView.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        _popView.layer.masksToBounds = YES;
        _popView.layer.cornerRadius = 7.0;
    }
    return _popView;
}
//titleLab
- (UILabel *)titleLab{
    if (!_titleLab){
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
//image
- (UIImageView *)image{
    if (!_image){
        _image = [[UIImageView alloc]init];
        _image.image = [UIImage imageNamed:@"SureImage"];
    }
    return _image;
}
#pragma mark - 计算文字宽度
- (CGFloat)calculateTheWidth:(NSString *)titleText{
    CGSize originSize = [titleText sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20],NSFontAttributeName,nil]];
    return originSize.width;
}
//设置位置
- (void)setPosition:(CGFloat)width{
    self.frame = CGRectMake(DEVICESCREENWIDTH * 0.5 - (width + 25) * 0.5, 300, width + 25, 70);
    self.popView.frame = self.frame;
    //image
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.popView);
        make.top.equalTo(self.popView).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 25));
    }];
    //titleLab
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.popView);
        make.top.equalTo(self.image.mas_bottom).offset(1);
        make.size.mas_equalTo(CGSizeMake(width, 30));
    }];
}
@end
