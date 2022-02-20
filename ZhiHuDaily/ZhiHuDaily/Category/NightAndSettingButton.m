//
//  NightAndSettingButton.m
//  OthersJumpDemo
//
//  Created by 宋开开 on 2022/2/8.
//

#import "NightAndSettingButton.h"

@implementation NightAndSettingButton
//定义属性type的setter方法，功能：使文字居中
- (void)setLzType:(MyButtonType)type {
    self.type = type;
    if (type != MyButtonTypeNomal) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}
//重写位置方法(图片上文字下）
- (CGRect)imageRectForContentRect:(CGRect)contentRect {

     CGFloat inteval = CGRectGetWidth(contentRect)/4.0;
//     inteval = MIN(inteval, 6);

     //设置图片的宽高为button宽度的7/8;
     CGFloat imageW = CGRectGetWidth(contentRect) - 2 *inteval;

     CGRect rect = CGRectMake(inteval, inteval * 1.5, imageW, imageW);

     return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {

     CGFloat inteval = CGRectGetWidth(contentRect)/16.0;
     inteval = MIN(inteval, 6);

     //设置图片的宽高为button宽度的7/8;
     CGFloat imageW = CGRectGetWidth(contentRect) - 2 * inteval;

     CGRect rect = CGRectMake(0, inteval*2 + imageW, CGRectGetWidth(contentRect) , CGRectGetHeight(contentRect) - 3*inteval - imageW);

     return rect;
}


@end
