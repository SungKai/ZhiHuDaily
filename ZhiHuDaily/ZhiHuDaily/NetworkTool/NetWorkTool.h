//
//  NetWorkTool.h
//  ZhihuDemoAFN_MJ
//
//  Created by 宋开开 on 2022/2/2.
//

//网络请求工具类封装
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkTool : AFHTTPSessionManager
//单例
+ (instancetype)shareNetworkTool;
//请求最新新闻
- (void)latest:(void(^)(NSDictionary *))diliverLatest;
//过往新闻
- (void)before:(NSString *)date And:(void(^)(NSDictionary *))diliverBefore;
//文章内容
- (void)article:(NSString *)ID And:(void(^)(NSDictionary *))diliverArticle;
//额外信息
- (void)storyExtra:(NSString *)ID And:(void(^)(NSDictionary *))diliverExtra;
@end

NS_ASSUME_NONNULL_END
