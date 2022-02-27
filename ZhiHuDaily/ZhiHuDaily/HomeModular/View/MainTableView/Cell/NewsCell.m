//
//  NewsCell.m
//  HomeCellDemo
//
//  Created by 宋开开 on 2022/2/10.
//

#import "NewsCell.h"
#import "Masonry.h"
#import <UIImageView+AFNetworking.h>
#import "UILabel+AutoHeight.h"
#import "HomeViewController.h"
#import "Header.h"

@implementation NewsCell
//初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor colorNamed:@"255_255_255&26_26_26"];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.hint];
        [self.contentView addSubview:self.image];
        [self setPosition];
    }
    return self;
}
#pragma mark - 方法
//默认状态下的cell
+ (NewsCell *)creatCellDefault:(UITableView *)tableView{
    static NSString *newsID = @"newsID";
    //复用池
    NewsCell *newsCell = [tableView dequeueReusableCellWithIdentifier:newsID];
    if (newsCell == nil) {
        newsCell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsID];
    }
    return newsCell;
}
//拿到数据，设置cell的数据
- (NewsCell *)cellWithInformation:(NewsCell *)cell WithTitleText:(NSString *)titleText WithHintText:(NSString *)hintText WithImageURL:(NSString *)imageURL{
    cell.title.text = titleText;
    cell.hint.text = hintText;
    [cell.image setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    cell.title.backgroundColor = [UIColor clearColor];
    cell.hint.backgroundColor = [UIColor clearColor];
    [cell calculateTitle:cell AndTitleText:titleText];
    [cell setPosition];
    return cell;
}
//设置title行数
- (void)calculateTitle:(NewsCell *)cell AndTitleText:(NSString *)str{
    CGRect tempTitleFrame = cell.title.frame;
    tempTitleFrame.size = [cell.title MaxLabelWidth:str FontOfSize:17 MaxWidth:WIDTH  MaxNumberOfLine:2 Interval:3];
    tempTitleFrame.origin = CGPointMake(20, 15);
    cell.title.frame = tempTitleFrame;
    cell.hint.frame = CGRectMake(cell.title.frame.origin.x, cell.title.frame.origin.y + cell.title.frame.size.height + 3, cell.title.frame.size.width, 16);
}
#pragma mark - 懒加载
- (UILabel *)title{
    if (!_title){
        _title = [[UILabel alloc]init];
        _title.textColor = [UIColor colorNamed:@"0_0_0&154_153_154"];
        _title.font = [UIFont boldSystemFontOfSize: 17];
        _title.backgroundColor = [UIColor lightGrayColor];
        _title.frame = CGRectMake(20, 15, WIDTH, 43);
        
    }
    return _title;
}
- (UILabel *)hint{
    if (!_hint){
        _hint = [[UILabel alloc]init];
        _hint.textColor = [UIColor lightGrayColor];
        _hint.font = [UIFont systemFontOfSize:14];
        _hint.backgroundColor = [UIColor lightGrayColor];
        _hint.frame = CGRectMake(20, 64, WIDTH, 16);
    }
    return _hint;
}
- (UIImageView *)image{
    if (!_image){
        _image = [[UIImageView alloc]init];
        _image.backgroundColor = [UIColor grayColor];
        _image.layer.masksToBounds = YES;
        _image.layer.cornerRadius = 4;
        _image.backgroundColor = [UIColor lightGrayColor];
    }
    return _image;
}
#pragma mark - 设置默认尺寸
- (void)setPosition{
    //image
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-18);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(76, 76));
    }];
}

@end
