//
//  DataModel.h
//  HomeCellDemo
//
//  Created by 宋开开 on 2022/2/10.
//

//此类为模块封装，具体每个cell新闻的信息，直接对接返回的JSON数据
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject

@property (nonatomic,copy) NSString * image_hue;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * imageURL;
@property (nonatomic,copy) NSString * hint;
@property (nonatomic, copy) NSString * ID;
//NewsCell创建
- (instancetype)initWithNewsDic:(NSDictionary *)dic;
//Banner创建
- (instancetype)initWithBannerDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
