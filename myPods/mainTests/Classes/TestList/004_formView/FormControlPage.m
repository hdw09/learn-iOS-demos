//
//  SelfUIControlPage.m
//  Pods
//
//  Created by David on 16/9/50.
//
//

#import "FormControlPage.h"
#import "MTBCYFormInputView.h";

@interface FormControlPage ()

@property (nonatomic, strong) UIScrollView *mainView;

@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *primaryButton;
@property (nonatomic, strong) UIButton *successButton;
@property (nonatomic, strong) UIView *contentView;



@property (nonatomic, strong) MTBCYFormInputView *input1;
@property (nonatomic, strong) MTBCYFormInputView *input2;
@property (nonatomic, strong) MTBCYFormInputView *input3;
@property (nonatomic, strong) MTBCYFormInputView *input4;

@end

@implementation FormControlPage

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
    [self.contentView addSubview:self.defaultButton];
    self.primaryButton = [[UIButton alloc]init];
    [self.contentView addSubview:self.primaryButton];
    self.successButton = [[UIButton alloc]init];
    [self.contentView addSubview:self.successButton];
    
    [self.contentView addSubview:self.input1];
    [self.input1 setInputTile:@"门店地址"];
    [self.input1 setInputplaceholderText:@"点击选择门店地址"];
    [self.contentView addSubview:self.input2];
    [self.input2 setInputTile:@"门店电话"];
    [self.input2 setInputplaceholderText:@"请输入电话号码"];
    [self.contentView addSubview:self.input3];
    [self.input3 setInputTile:@"WiFi服务"];
    [self.contentView addSubview:self.input4];
    [self.input4 setInputTile:@"人均消费"];
    [self.input4 setInputplaceholderText:@"请输入金额"];
    
    
    
    [self.defaultButton defaultStyle];
    [self.primaryButton primaryStyle];
    [self.successButton successStyle];
   
}

- (void)bindEvents
{
    [self.defaultButton setTitle:@"hahahahhaha" forState:UIControlStateNormal];
    [self.defaultButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click
{
    NSLog(@"%f",self.mainView.contentSize.height);
    [self.input1 resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self updateViewConstraints];
}


-(void)updateViewConstraints
{
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
    
    [self.input1 mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.successButton.mas_bottom).offset(10);
        make.right.left.equalTo(self.view);
    }];
    
    [self.input2 mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.input1.mas_bottom);
        make.right.left.equalTo(self.view);
    }];
    
    [self.input3 mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.input2.mas_bottom);
        make.right.left.equalTo(self.view);
    }];
    
    [self.input4 mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.input3.mas_bottom);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.mainView).offset(10);
    }];
   
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.top.bottom.equalTo(self.mainView).offset(10);
    }];
    [super updateViewConstraints];
}



-(MTBCYFormInputView *)input1
{
    if (!_input1) {
        _input1 = [[MTBCYFormInputView alloc] init];
    }
    return _input1;
}

-(MTBCYFormInputView *)input2
{
    if (!_input2) {
        _input2 = [[MTBCYFormInputView alloc] init];
    }
    return _input2;
}

-(MTBCYFormInputView *)input3
{
    if (!_input3) {
        _input3 = [[MTBCYFormInputView alloc] init];
    }
    return _input3;
}

-(MTBCYFormInputView *)input4
{
    if (!_input4) {
        _input4 = [[MTBCYFormInputView alloc] init];
    }
    return _input4;
}

@end
