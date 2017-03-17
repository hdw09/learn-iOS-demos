//
//  TodayViewController.m
//  widgetT
//
//  Created by David on 2016/10/12.
//  Copyright © 2016年 David. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "Masonry.h"

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, strong) UIView *testBackground;
@property (nonatomic, strong) UIButton *aButton;
@property (nonatomic, strong) UIButton *bButton;
@property (nonatomic, strong) UIButton *cButton;



@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    [self.view addSubview:self.testBackground];
    [self.view addSubview:self.aButton];
    [self.view addSubview:self.bButton];
    [self.view addSubview:self.cButton];
    [self.view setNeedsUpdateConstraints];
}

-(void)updateViewConstraints
{
    
    [self.testBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.aButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@140);
        make.height.equalTo(@40);
        
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(@115);
    }];
    
    [self.bButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@140);
        make.height.equalTo(@40);
        
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(-10);
    }];
    
    [self.cButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@140);
        make.height.equalTo(@40);
        
        make.top.left.equalTo(self.view).offset(10);
    }];
    
    
    [super updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    //self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    [super viewWillAppear:animated];
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeCompact;
    NSLog(@"%f  ---+++----%f",self.view.bounds.size.width,self.view.bounds.size.height);
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    NSLog(@"maxSize(w:%f h:%f)",maxSize.width,maxSize.height);
    
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
    } else {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
    }
    
}

- (UIView *)testBackground
{
    if (_testBackground == nil) {
        _testBackground = [[UIView alloc]initWithFrame:CGRectZero];
        _testBackground.backgroundColor = UIColorFromRGB(0x880000);
    }
    return _testBackground;
}

- (UIButton *)aButton
{
    if (_aButton == nil) {
        _aButton = [[UIButton alloc]init];
        _aButton.backgroundColor = UIColorFromRGB(0x007700);
        [_aButton setTitle:@"我是测试按钮A" forState:UIControlStateNormal];
        [_aButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aButton;
}

- (UIButton *)bButton
{
    if (_bButton == nil) {
        _bButton = [[UIButton alloc]init];
        _bButton.backgroundColor = UIColorFromRGB(0x000077);
        [_bButton setTitle:@"我是测试按钮B" forState:UIControlStateNormal];
        [_bButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bButton;
}

-(UIButton *)cButton
{
    if (_cButton == nil) {
        _cButton = [[UIButton alloc]init];
        _cButton.backgroundColor = UIColorFromRGB(0x880077);
        [_cButton setTitle:@"我是测试按钮C" forState:UIControlStateNormal];
        [_cButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cButton;
}

- (void)click:(id)sender
{
    NSLog(@"我是测试按钮:%@",sender);
    UIButton *temp = (UIButton *)sender;
    if ([temp.titleLabel.text isEqualToString:@"我是测试按钮A"]) {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 400);
    } else if ([temp.titleLabel.text isEqualToString:@"我是测试按钮B"]){//我是测试按钮B
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 150);
    } else {
        NSURL *url = [NSURL URLWithString:@"hdwtest://fromwidgetT"];
        [self.extensionContext openURL:url completionHandler:nil];
    }
    
}



@end
