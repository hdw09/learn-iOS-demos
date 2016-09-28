//
//  EmptyPage.m
//  Pods
//
//  Created by David on 16/9/27.
//
//

#import "EmptyPage.h"

@interface EmptyPage ()

@property (nonatomic, strong) UIImageView *emptyImageView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation EmptyPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    [self updateViewConstraints];
}

- (void)addSubViews
{
    [self.view addSubview:self.emptyImageView];
    [self.view addSubview:self.textLabel];
}

-(void)updateViewConstraints
{
    
    [self.emptyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-50);
    }];
    
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.emptyImageView.mas_bottom).offset(5);
    }];
    
    [super updateViewConstraints];
}

-(UIImageView *)emptyImageView
{
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc]init];
        _emptyImageView.image = [MainTestsBundleGeter getImage:@"empty.png"];
    }
    return _emptyImageView;
}

-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.font = Font(12);
        _textLabel.text = @"想要去火星，还没准备好(,,• ₃ •,,)";
        _textLabel.textColor = UIColorFromRGB(0x5f5f5f);
    }
    return _textLabel;
}

@end
