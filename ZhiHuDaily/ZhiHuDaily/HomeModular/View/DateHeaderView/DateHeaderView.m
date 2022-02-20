//
//  DateHeaderView.m
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/15.
//

#import "DateHeaderView.h"
#import "Masonry.h"
@implementation DateHeaderView
- (instancetype)initWithDateHeaderViewWithDate:(NSString *)date{
    self = [super init];
    if (self){
        [self addSubview:self.dateLabel];
        [self addSubview:self.line];
        self.dateLabel.text = date;
        [self setPosition];
    }
    return self;
}
#pragma mark - 懒加载
- (UILabel *)dateLabel{
    if (!_dateLabel){
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textColor = [UIColor colorNamed:@"155_155_155&97_97_97"];

        _dateLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _dateLabel;
}
- (UIView *)line{
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor colorNamed:@"235_235_235&68_68_68"];
    }
    return _line;
}
#pragma mark - 设置尺寸
- (void)setPosition{
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(18);
        make.size.mas_equalTo(CGSizeMake(70, 15));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.left.equalTo(self.dateLabel.mas_right).offset(6);
        make.height.mas_equalTo(1);
    }];
}
@end
