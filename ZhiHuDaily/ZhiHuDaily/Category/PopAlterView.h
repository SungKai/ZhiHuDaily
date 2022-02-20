//
//  PopAlterView.h
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/19.
//
/*
 自定义提示框
 具有自动消失功能
 可以根据传进来的文字长短设置提示框的宽度
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopAlterView : UIView
//创建
- (instancetype)initWithPopAlterViewTheText:(NSString *)text;
//展现提示框
- (void)showThePopAlterView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
