//
//  EverydayNewsModel.m
//  HomeCellDemo
//
//  Created by 宋开开 on 2022/2/10.
//
#import <Foundation/Foundation.h>
#import <UIkit/UIkit.h>
#import "EverydayNewsModel.h"
#import "NewsCell.h"

@interface EverydayNewsModel()

@end
@implementation EverydayNewsModel
- (instancetype)init{
    self = [super init];
    if (self){
        self.everydayNews = [[NSMutableArray alloc]init];
    }
    return self;
}
#pragma mark - 网络请求
//请求 Lastest数据,相当于刷新, 删除其他数据
- (void)gainLatestData:(void(^)(void))reloadDataOfNewsCell{
    [DayModel getLatest:^(DayModel * _Nonnull everydayData) {
        [self.everydayNews removeAllObjects];
        [self.everydayNews addObject:everydayData];
        reloadDataOfNewsCell();
        }];
}
//请求before数据
- (void)gainBeforeDataAndDate:(NSString *)date And:(void(^)(void))reloadBeforeDataOfNewsCell{
    [DayModel getBeforeDate:date AndModel:^(DayModel * _Nonnull beforeDate) {
        [self.everydayNews addObject:beforeDate];
        reloadBeforeDataOfNewsCell();
    }];
}


@end
