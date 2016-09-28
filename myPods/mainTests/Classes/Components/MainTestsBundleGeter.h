//
//  MainTestsBundleGeter.h
//  Pods
//
//  Created by David on 16/9/26.
//
//

#import <Foundation/Foundation.h>

@interface MainTestsBundleGeter : NSObject

+ (NSBundle *)getCurrentBundle;

+ (UIImage *)getImage:(NSString *)imageName;

@end
