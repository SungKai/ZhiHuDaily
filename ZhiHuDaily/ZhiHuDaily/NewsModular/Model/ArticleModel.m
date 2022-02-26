//
//  ArticleModel.m
//  WKWebViewDemo
//
//  Created by 宋开开 on 2022/2/19.
//

#import "ArticleModel.h"
#import "NetWorkTool.h"
@implementation ArticleModel
//文章内容
- (void)getArticleID:(NSString *)ID AndModel:(void(^)(ArticleModel *))articleModel{
    [[NetworkTool shareNetworkTool]article:ID And:^(NSDictionary * _Nonnull dic) {
            //转模型
        ArticleModel *article = [[ArticleModel alloc]init];
        article.url = dic[@"url"];
        articleModel(article);
        }];
}

//新闻额外信息
- (void)getStoryExtra:(NSString *)ID AndModel:(void(^)(ArticleModel *))storyModel{
    [[NetworkTool shareNetworkTool]storyExtra:ID And:^(NSDictionary * _Nonnull dic) {
            ArticleModel *article = [[ArticleModel alloc]init];
            article.popularity = [dic[@"popularity"]longValue];
            article.comments = [dic[@"comments"]longValue];
        storyModel(article);
        }];
}
@end
