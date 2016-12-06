//
//  ThereDTouchPage.m
//  Pods
//
//  Created by David on 16/9/29.
//
//

#import "ThereDTouchPage.h"

@interface ThereDTouchPage ()

@end

@implementation ThereDTouchPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray <UIApplicationShortcutItem *> *updatedShortcutItems = [NSMutableArray new];
    UIMutableApplicationShortcutItem *aMutableShortcutItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"这里是不是随便啊" localizedTitle:@"联系大卫"];
    [updatedShortcutItems addObject:aMutableShortcutItem];
    [[UIApplication sharedApplication] setShortcutItems: updatedShortcutItems];
}

@end
