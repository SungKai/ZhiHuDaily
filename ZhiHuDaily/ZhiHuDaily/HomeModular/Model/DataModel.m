//
//  DataModel.m
//  HomeCellDemo
//
//  Created by 宋开开 on 2022/2/10.
//

#import "DataModel.h"

@implementation DataModel
//NewsCell创建
- (instancetype)initWithNewsDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.hint = dic[@"hint"];
        NSArray *ary = dic[@"images"]; //是数组，要取[0]
        self.imageURL = ary[0];
        self.image_hue = dic[@"image_hue"];
        self.ID = dic[@"id"];
        self.url = dic[@"url"];
    }
    return self;
}
//BannerCell创建
- (instancetype)initWithBannerDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.hint = dic[@"hint"];
        self.image = dic[@"image"];
        self.image_hue = dic[@"image_hue"];
        self.ID = dic[@"id"];
        self.url = dic[@"url"];
    }
    return self;
}
@end
