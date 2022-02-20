//
//  DateHeaderView.h
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/15.
//
//此类为Before新闻最上方的日期
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateHeaderView : UIView
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *line;
//表头日期
- (instancetype)initWithDateHeaderViewWithDate:(NSString *)date;

@end

NS_ASSUME_NONNULL_END
