//
//  MainTestsBundleGeter.m
//  Pods
//
//  Created by David on 16/9/26.
//
//

#import "MainTestsBundleGeter.h"

@implementation MainTestsBundleGeter

+ (NSBundle *)getCurrentBundle
{
    NSBundle *bundles = [NSBundle bundleForClass:[MainTestsBundleGeter class]];
    NSURL * url = [bundles URLForResource:@"mainTestsBundle" withExtension:@"bundle"];
    if (url != nil) {
        return [NSBundle bundleWithURL:url];
    } else {
        return nil;
    }
}

+ (UIImage *)getImage:(NSString *)imageName
{
    NSBundle * bundle = [MainTestsBundleGeter getCurrentBundle];
    if (bundle != nil) {
        return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        return nil;
    }
    
}

@end
