//
//  NewsCell.h
//  HomeCellDemo
//
//  Created by 宋开开 on 2022/2/10.
//

//此页为新闻cell
#import <UIKit/UIKit.h>
#import "DataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewsCell : UITableViewCell
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *hint;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) DataModel *data;  //有问题的
+ (NewsCell *)creatCellDefault:(UITableView *)tableView;
- (NewsCell *)cellWithInformation:(NewsCell *)cell WithTitleText:(NSString *)titleText WithHintText:(NSString *)hintText WithImageURL:(NSString *)imageURL;
@end

NS_ASSUME_NONNULL_END
