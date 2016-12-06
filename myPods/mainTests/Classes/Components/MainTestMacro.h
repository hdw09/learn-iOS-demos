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

#endif /* MainTestMacro_h */
