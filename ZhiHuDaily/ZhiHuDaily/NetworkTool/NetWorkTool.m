//
//  NetWorkTool.m
//  ZhihuDemoAFN_MJ
//
//  Created by 宋开开 on 2022/2/2.
//

#import "NetWorkTool.h"

@implementation NetworkTool
//单例模式
+ (instancetype)shareNetworkTool{
    static NetworkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://news-at.zhihu.com/api/3/"]];
    });
    return instance;
}
//网络请求
//最新新闻
- (void)latest:(void(^)(NSDictionary *))diliverLatest{
    //GET请求
    [self GET:@"stories/latest" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"latest请求成功----------");
        diliverLatest(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"latest请求失败---------%@", error);
    }];
}
//Before新闻
- (void)before:(NSString *)date And:(void(^)(NSDictionary *))diliverBefore{
    //GET请求
    [self GET:[NSString stringWithFormat:@"stories/before/%@", date] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"before请求成功----------");
        diliverBefore(responseObject);
    }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"before请求失败---------%@", error);
    }];
}
//article新闻详情页
- (void)article:(NSString *)ID And:(void(^)(NSDictionary *))diliverArticle{
    [self GET:[NSString stringWithFormat:@"news/%@", ID] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"article请求成功----------");
        diliverArticle(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"article请求失败---------%@", error);
    }];
}
//新闻额外信息
- (void)storyExtra:(NSString *)ID And:(void(^)(NSDictionary *))diliverExtra{
    [self GET:[NSString stringWithFormat:@"story-extra/%@", ID] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"storyExtra请求成功----------");
        diliverExtra(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"storyExtra请求失败---------%@", error);
    }];
}

@end
