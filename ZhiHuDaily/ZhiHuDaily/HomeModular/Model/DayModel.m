//
//  DayModel.m
//  HomeCellDemo
//
//  Created by 宋开开 on 2022/2/10.
//

#import "DayModel.h"
#import "DataModel.h"
#import "NetWorkTool.h"

@implementation DayModel
//创建
- (instancetype)init{
    self = [super init];
    if (self) {
        self.date = [NSString string];
        self.stories = [[NSArray alloc] init];
        self.top_stories = [[NSArray alloc] init];
    }
    return self;
}
//Latest
+ (void)getLatest:(void(^)(DayModel *))model{
    [[NetworkTool shareNetworkTool] latest:^(NSDictionary * _Nonnull dict) {
        DayModel *lastestModel = [[DayModel alloc]init];
        lastestModel.date = dict[@"date"];
        lastestModel.stories = [lastestModel newsArray:dict[@"stories"]];
        lastestModel.top_stories = [lastestModel bannerArray:dict[@"top_stories"]];
        model(lastestModel);
    }];
}
//Before
+ (void)getBeforeDate:(NSString *)date AndModel:(void(^)(DayModel *))model{
    [[NetworkTool shareNetworkTool] before:date And:^(NSDictionary * _Nonnull dict) {
        DayModel *lastestModel = [[DayModel alloc]init];
        lastestModel.date = dict[@"date"];
        lastestModel.stories = [lastestModel newsArray:dict[@"stories"]];
        NSLog(@"%@", lastestModel.stories[1].title);
        model(lastestModel);
    }];
}
//news数据
- (NSArray *)newsArray:(NSArray *)newsArray{
    NSMutableArray *tem = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in newsArray){
        DataModel *dataModel = [[DataModel alloc]initWithNewsDic:dic];
        [tem addObject:dataModel];
    }
    return tem;
}
//banner数据
- (NSArray *)bannerArray:(NSArray *)newsArray{
    NSMutableArray *tem = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in newsArray){
        DataModel *dataModel = [[DataModel alloc]initWithBannerDic:dic];
        [tem addObject:dataModel];
    }
    return tem;
}
@end
