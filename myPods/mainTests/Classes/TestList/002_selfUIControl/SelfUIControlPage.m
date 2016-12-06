//
//  SelfUIControlPage.m
//  Pods
//
//  Created by David on 16/9/50.
//
//

#import "SelfUIControlPage.h"

@interface SelfUIControlPage ()

@property (nonatomic, strong) UIScrollView *mainView;

@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *primaryButton;
@property (nonatomic, strong) UIButton *successButton;
@property (nonatomic, strong) UIButton *infoButton;
@property (nonatomic, strong) UIButton *warningButton;
@property (nonatomic, strong) UIButton *dangerButton;
@property (nonatomic, strong) UIButton *bookmarkButton;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation SelfUIControlPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self bindEvents];
}

- (void)setupViews
{
    self.mainView = [[UIScrollView alloc]init];
    self.contentView = [[UIView alloc]init];
    self.mainView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.contentView.backgroundColor = UIColorFromRGB(0xffffff);
    [self.mainView addSubview:_contentView];
    [self.view addSubview:self.mainView];
    
    self.defaultButton = [[UIButton alloc]init];
    [self.mainView addSubview:self.defaultButton];
    self.primaryButton = [[UIButton alloc]init];
    [self.mainView addSubview:self.primaryButton];
    self.successButton = [[UIButton alloc]init];
    [self.mainView addSubview:self.successButton];
    self.infoButton = [[UIButton alloc]init];
    [self.mainView addSubview:self.infoButton];
    self.warningButton = [[UIButton alloc]init];
    [self.mainView addSubview:self.warningButton];
    self.bookmarkButton = [[UIButton alloc]init];
    [self.mainView addSubview:self.bookmarkButton];
    self.doneButton = [[UIButton alloc]init];
    [self.mainView addSubview:self.doneButton];
    self.downloadButton = [[UIButton alloc]init];
    [self.mainView addSubview:self.downloadButton];
    self.deleteButton = [[UIButton alloc]init];
    [self.mainView addSubview:self.deleteButton];
    self.dangerButton = [[UIButton alloc]init];
    [self.mainView addSubview:self.dangerButton];
    
    
    [self.defaultButton defaultStyle];
    [self.primaryButton primaryStyle];
    [self.successButton successStyle];
    [self.infoButton infoStyle];
    [self.warningButton warningStyle];
    [self.dangerButton dangerStyle];
    
    [self.bookmarkButton primaryStyle];
    [self.bookmarkButton addAwesomeIcon:FAIconBookmark beforeTitle:YES];
    
    [self.doneButton successStyle];
    [self.doneButton addAwesomeIcon:FAIconCheck beforeTitle:NO];
    
    [self.deleteButton dangerStyle];
    [self.deleteButton addAwesomeIcon:FAIconRemove beforeTitle:YES];
    
    [self.downloadButton defaultStyle];
    [self.downloadButton addAwesomeIcon:FAIconDownloadAlt beforeTitle:NO];
}

- (void)bindEvents
{
    [self.defaultButton setTitle:@"hahahahhaha" forState:UIControlStateNormal];
    [self.defaultButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click
{
    NSLog(@"%f",self.mainView.contentSize.height);
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self updateViewConstraints];
}


-(void)updateViewConstraints
{
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.defaultButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView).offset(20);
        make.top.equalTo(self.mainView);
        make.right.equalTo(self.mainView);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    [self.primaryButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.defaultButton.mas_bottom).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    [self.successButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.primaryButton.mas_bottom).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    [self.infoButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.successButton.mas_bottom).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    [self.warningButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.infoButton.mas_bottom).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    [self.dangerButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.warningButton.mas_bottom).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    [self.bookmarkButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.dangerButton.mas_bottom).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    [self.doneButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.bookmarkButton.mas_bottom).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    [self.downloadButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.doneButton.mas_bottom).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    [self.deleteButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.downloadButton.mas_bottom).offset(10);
        make.bottom.equalTo(self.mainView);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.top.bottom.equalTo(self.mainView);
    }];
    [super updateViewConstraints];
}

@end
