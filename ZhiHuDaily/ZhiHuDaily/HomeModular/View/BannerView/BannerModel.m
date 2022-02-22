//
//  BannerModel.m
//  ZhiHuDaily
//
//  Created by apple on 2022/2/21.
//

#import "BannerModel.h"

@implementation BannerModel

- (instancetype)initWithImage:(NSString *)image title:(NSString *)title hint:(NSString *)hint ID:(NSString *)ID{
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        self.hint = hint;
        self.ID = ID;
    }
    return  self;
}
@end
