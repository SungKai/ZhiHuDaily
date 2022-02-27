//
//  Header.h
//  ZhiHuDaily
//
//  Created by SSR on 2022/2/26.
//

#ifndef Header_h
#define Header_h


//偏好设置的宏定义
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]
//屏幕的宽和长
#define DEVICESCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define DEVICESCREENHEIGHT [[UIScreen mainScreen]bounds].size.height
//cell的title文字宽度 76:图片的宽，两个18:图片右侧距离屏幕右边的距离，文字右侧距离图片左侧的距离，20:文字左侧距离屏幕左侧的距离
#define WIDTH DEVICESCREENWIDTH - 76 - 18 - 20 - 18


#endif /* Header_h */
