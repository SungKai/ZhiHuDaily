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

@interface EverydayNewsModel()<UITableViewDataSource>

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
//请求Lastest数据
- (void)gainLatestData:(void(^)(void))reloadDataOfNewsCell{
    [DayModel getLatest:^(DayModel * _Nonnull everydayData) {
        [self.everydayNews addObject:everydayData];
        NSLog(@"oooooofsdasdfgfdgasdgsadao=======%@", self.everydayNews[0].top_stories[1].title);
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
#pragma mark - <UITableViewDataSourse>
//行数section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.everydayNews.count;
}
//每行的cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.everydayNews[section].stories.count;
//    return self.everydayNews.count == section ? 6 : self.everydayNews[section].stories.count;
}
//每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.everydayNews.count == indexPath.section){
        return [self.sourseNewsDelegate tableView:tableView SourseNewsForSourse:nil];
    }
    return [self.sourseNewsDelegate tableView:tableView SourseNewsForSourse:self.everydayNews[indexPath.section].stories[indexPath.row]];
}


@end
