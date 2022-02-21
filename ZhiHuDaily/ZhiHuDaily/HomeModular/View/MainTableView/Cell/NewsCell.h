//
//  NewsCell.h
//  HomeCellDemo
//
//  Created by 宋开开 on 2022/2/10.
//

//此页为新闻cell
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsCell : UITableViewCell
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *hint;
@property (nonatomic, strong) UIImageView *image;

+ (NewsCell *)creatCellDefault:(UITableView *)tableView;
- (NewsCell *)cellWithInformation:(NewsCell *)cell WithTitleText:(NSString *)titleText WithHintText:(NSString *)hintText WithImageURL:(NSString *)imageURL;
@end

NS_ASSUME_NONNULL_END
