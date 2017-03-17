//
//  MainTestMacro.h
//  Pods
//
//  Created by David on 16/9/26.
//
//

#ifndef MainTestMacro_h
#define MainTestMacro_h

#import "MainTestsBundleGeter.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"
#import "BaseViewController.h"
#import "UIButton+Bootstrap.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HEXCOLOR(hexValue)              [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : 1.0]

#define FontS(name,fsize) [UIFont fontWithName:name size:fsize]
#define Font(size) FontS(@"AmericanTypewriter",size)

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height


#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


/*  美团绿 */
#define IMERCHANT_GREEN RGBCOLOR(0x1f, 0xbb, 0xaa)
/*  桔黄色，主要用于部分页面，如评价等 */
#define IMERCHANT_YELLOW RGBCOLOR(0xfa, 0x95, 0x2f)

/* 灰度渐变，从黑色渐变到白 */
#define IMERCHANT_BLACK RGBCOLOR(0x00, 0x00, 0x00)
#define IMERCHANT_GRAY1 RGBCOLOR(0x33, 0x33, 0x33)
#define IMERCHANT_GRAY2 RGBCOLOR(0x66, 0x66, 0x66)
#define IMERCHANT_GRAY3 RGBCOLOR(0x99, 0x99, 0x99)
#define IMERCHANT_GRAY4 RGBCOLOR(0xbc, 0xbc, 0xbc)
#define IMERCHANT_GRAY5 RGBCOLOR(0xc9, 0xc9, 0xc9)
#define IMERCHANT_GRAY6 RGBCOLOR(0xd5, 0xd5, 0xd5)
#define IMERCHANT_GRAY7 RGBCOLOR(0xe8, 0xe8, 0xe8)
#define IMERCHANT_GRAY8 RGBCOLOR(0xee, 0xee, 0xee)
#define IMERCHANT_GRAY9 RGBCOLOR(0xf8, 0xf8, 0xf8)
#define IMERCHANT_WHITE RGBCOLOR(0xff, 0xff, 0xff)

/* 橘红到橘黄渐变，从深到浅 */
#define IMERCHANT_ORANGE1 RGBCOLOR(0xf7,0x61,0x20)
#define IMERCHANT_ORANGE2 RGBCOLOR(0xf8,0x72,0x19)
#define IMERCHANT_ORANGE3 RGBCOLOR(0xff,0x89,0x00)
#define IMERCHANT_ORANGE4 RGBCOLOR(0xff,0x9d,0x3c)
#define IMERCHANT_ORANGE5 RGBCOLOR(0xff,0xbb,0x77)

/* 绿色渐变，从深到浅 */
#define IMERCHANT_DARKGREEN1 RGBCOLOR(0x00,0xa7,0x95) //比如首页美团码输入框边框
#define IMERCHANT_DARKGREEN2 RGBCOLOR(0x20,0xa8,0x9a) //比如首页美团码输入框内部
#define IMERCHANT_GREEN1 RGBCOLOR(0x00,0xa6,0x92)
#define IMERCHANT_GREEN2 RGBCOLOR(0x2b,0xb8,0xaa)
#define IMERCHANT_GREEN3 RGBCOLOR(0x3d,0xc6,0xb6) // 比如首页上面那一大块绿色
#define IMERCHANT_GREEN4 RGBCOLOR(0x5c,0xce,0xb3)
#define IMERCHANT_GREEN5 RGBCOLOR(0x8b,0xdd,0xd4)
#define IMERCHANT_GREENBG RGBCOLOR(0x3b,0xb7,0xaa)
#define IMERCHANT_GREENNAV RGBCOLOR(0x4a,0xc5,0xb6)

#endif /* MainTestMacro_h */
