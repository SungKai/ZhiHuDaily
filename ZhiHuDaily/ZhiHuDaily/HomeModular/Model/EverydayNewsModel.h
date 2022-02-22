//
//  EverydayNewsModel.h
//  HomeCellDemo
//
//  Created by 宋开开 on 2022/2/10.
//

//此类装载着每天的新闻数据
#import <Foundation/Foundation.h>
#import <UIkit/UIkit.h>
#import "DayModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EverydayNewsModel : NSObject
//每天的新闻
@property (nonatomic, strong) NSMutableArray<DayModel *> *everydayNews;
//请求Lastest数据
- (void)gainLatestData:(void(^)(void))reloadDataOfNewsCell;
//请求Before数据
- (void)gainBeforeDataAndDate:(NSString *)date And:(void(^)(void))reloadBeforeDataOfNewsCell;
@end

NS_ASSUME_NONNULL_END
