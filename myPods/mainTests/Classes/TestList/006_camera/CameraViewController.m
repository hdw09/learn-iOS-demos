//
//  TestsTableViewController.m
//  Pods
//
//  Created by David on 16/9/26.
//
//

#import "CameraViewController.h"
#import "MTVRCameraPage.h"

@interface CameraViewController()

@property (nonatomic, strong) UIButton *primaryButton;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.primaryButton = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - 150) / 2, ((ScreenHeight - 150) / 2), 150, 80)];
    [self.primaryButton setTitle:@"720相机" forState:UIControlStateNormal];
    [self.primaryButton primaryStyle];
    [self.view addSubview:self.primaryButton];
    [self.primaryButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick
{
    MTVRCameraPage * VRCameraPage = [[MTVRCameraPage alloc] init];
    [self.navigationController presentViewController:VRCameraPage animated:YES completion:nil];    
}

@end
