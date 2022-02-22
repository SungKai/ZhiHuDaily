//
//  BannerModel.h
//  ZhiHuDaily
//
//  Created by apple on 2022/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerModel : NSObject
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * hint;
@property (nonatomic, copy) NSString * ID;
- (instancetype)initWithImage:(NSString *)image title:(NSString *)title hint:(NSString *)hint ID:(NSString *)ID;
@end


NS_ASSUME_NONNULL_END
