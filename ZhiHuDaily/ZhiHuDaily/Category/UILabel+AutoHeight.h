//
//  UILabel+AutoHeight.h
//  ZhiHuDaily
//
//  Created by 宋开开 on 2022/2/16.
//
/*此分类为UILabel添加了一个能够根据文本内容来确定该UILabel的Frame，
 具有屏幕适配功能
 */
#import <UIKit/UIKit.h>

@interface UILabel (AutoHeight)

/// numberOflinesTotal
/// @param text UILabel的文本
/// @param size 想要的字号大小
/// @param left 距离屏幕左边的距离
/// @param right 距离屏幕右边的距离
/// @param top  情况一：想要顶部高度不变，文字向下延伸，如果是情况二，则该参数填0
/// @param bottom 情况二：想要底部高度不变，文字向上延伸，如果是情况一，则该参数填0
/// @param interval 行距
/// @param maxNumOfLine 最多限制在几行
- (CGRect)numberOflinesTotal:(NSString *)text AndFontOfSize:(NSInteger)size AndLeft:(CGFloat)left AndRight:(CGFloat)right AndTop:(CGFloat)top AndBottom:(CGFloat)bottom AndInterval:(CGFloat)interval AndMaxNumberOfLine:(NSInteger)maxNumOfLine;
@end

