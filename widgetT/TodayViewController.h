//
//  TodayViewController.h
//  widgetT
//
//  Created by David on 2016/10/12.
//  Copyright © 2016年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define FontS(name,fsize) [UIFont fontWithName:name size:fsize]
#define Font(size) FontS(@"AmericanTypewriter",size)

@interface TodayViewController : UIViewController

@end
