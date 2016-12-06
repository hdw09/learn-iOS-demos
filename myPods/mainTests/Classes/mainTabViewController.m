//
//  mainTabViewController.m
//  Pods
//
//  Created by David on 16/7/25.
//

#import "mainTabViewController.h"
#import "MeViewController.h"
#import "TestsTableViewController.h"

@interface mainTabViewController ()

@end

@implementation mainTabViewController

- (instancetype) initWithWindow:(UIWindow *)window
{
    self = [super init];
    if (self) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
        
        TestsTableViewController *testsListpage = [[TestsTableViewController alloc]init];
        MeViewController * myPage = [[MeViewController alloc]init];
        
        
        UINavigationController *wnvc = [[UINavigationController alloc]initWithRootViewController:testsListpage];
        UINavigationController *cnvc = [[UINavigationController alloc]initWithRootViewController:myPage];

        wnvc.tabBarItem.title = @"Demos";
        cnvc.tabBarItem.title = @"我";

        wnvc.tabBarItem.image = [MainTestsBundleGeter getImage:@"testList.png"];
        cnvc.tabBarItem.image = [MainTestsBundleGeter getImage:@"me.png"];

        self.viewControllers = @[wnvc,cnvc];
        window.rootViewController = self;
        window.backgroundColor = [UIColor whiteColor];
        [window makeKeyAndVisible];
    }
    return self;
}

@end
