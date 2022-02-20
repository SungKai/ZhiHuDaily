//
//  ArticleModel.h
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/19.
//
//此类用于网络请求新闻内容和新闻额外信息的，并且直接对接返回的JSON数据，转成Model
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleModel : NSObject
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *css;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *image_hue;
@property (nonatomic, copy) NSString *js;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger long_comments;
@property (nonatomic, assign) NSInteger popularity;
@property (nonatomic, assign) NSInteger short_comments;
@property (nonatomic, assign) NSInteger comments;

//转模型
//新闻内容
- (void)getArticleID:(NSString *)ID AndModel:(void(^)(ArticleModel *))model;
//新闻额外信息
- (void)getStoryExtra:(NSString *)ID AndModel:(void(^)(ArticleModel *))storyModel;
@end


NS_ASSUME_NONNULL_END



