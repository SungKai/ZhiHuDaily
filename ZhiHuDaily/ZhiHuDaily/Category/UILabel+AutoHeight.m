//
//  UILabel+AutoHeight.m
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/16.
//
  
#import "UILabel+AutoHeight.h"

@implementation UILabel (AutoHeight)

- (CGRect)numberOflinesTotal:(NSString *)text AndFontOfSize:(NSInteger)size AndLeft:(CGFloat)left AndRight:(CGFloat)right AndTop:(CGFloat)y AndBottom:(CGFloat)bottom AndInterval:(CGFloat)interval AndMaxNumberOfLine:(NSInteger)maxNumOfLine{
    //文字展开一行的宽度
    CGSize originSize = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:size],NSFontAttributeName,nil]];
    //计算宽度
    CGFloat width = DEVICESCREENWIDTH - left - right;
    //把所有文字都展现所需要的行数
    NSInteger count = originSize.width / width + 1;
    if (count > maxNumOfLine){
        count = maxNumOfLine;
    }
        self.numberOfLines = count;
    CGFloat height = count * originSize.height + interval * (count + 1);
    if (bottom){
        y = bottom - height;
    }
    return CGRectMake(left, y, width, height);
}
@end
