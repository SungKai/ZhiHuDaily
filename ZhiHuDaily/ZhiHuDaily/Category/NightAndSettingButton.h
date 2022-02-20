//
//  NightAndSettingButton.h
//  OthersJumpDemo
//
//  Created by 宋开开 on 2022/2/8.
//
/*自定义Button
 功能：修改默认状体下button文字右，图片左的情况，可自定义为图片上，文字下的情况
*/
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MyButtonType) {
    MyButtonTypeNomal  = 0,//默认
    MyButtonTypeLeft   = 1,//标题在左
    MyButtonTypeBottom = 2,//标题在下
};

@interface NightAndSettingButton : UIButton
@property (assign, nonatomic) MyButtonType type;
@end
