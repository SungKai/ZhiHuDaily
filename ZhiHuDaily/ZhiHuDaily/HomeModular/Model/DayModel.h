//
//  DayModel.h
//  HomeCellDemo
//
//  Created by 宋开开 on 2022/2/10.
//

//网络请求，一天的新闻，里面装着每个cell的新闻
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataModel.h"

NS_ASSUME_NONNULL_BEGIN
@class EverydayNewsModel;
@interface DayModel : NSObject

@property (nonatomic, copy) NSString * date;
@property (nonatomic, strong) NSArray<DataModel *> * top_stories;
@property (nonatomic, strong) NSArray<DataModel *> * stories;
@property (nonatomic, strong) EverydayNewsModel *everydayNewsModel;
//请求Lastest数据
+ (void)getLatest:(void(^)(DayModel *))model;
//请求Before数据
+ (void)getBeforeDate:(NSString *)date AndModel:(void(^)(DayModel *))model;
@end

NS_ASSUME_NONNULL_END
