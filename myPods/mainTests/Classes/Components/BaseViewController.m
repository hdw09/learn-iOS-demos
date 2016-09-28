//
//  BaseViewController.m
//  Pods
//
//  Created by David on 16/9/27.
//
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
}

- (void)setupNavigation
{
    //self.navigationItem.title = @"";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;//从导航条下面开始
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x49b9f0);
    
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
