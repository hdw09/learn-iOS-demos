//
//  MTBCYFormInputView.m
//  Pods
//
//  Created by David on 2016/10/20.
//
//

#import "MTBCYFormInputView.h"

@interface MTBCYFormInputView()<UITextFieldDelegate>

@property (nonatomic, assign) MTBCYFormInputStyle formInputStyle;
@property (nonatomic, strong) UILabel *inputTileLabel;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIView *bottomline;

@end

@implementation MTBCYFormInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.formInputStyle = MTBCYFormInputStyleNormal;
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithInputStyle:(MTBCYFormInputStyle)style
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.formInputStyle = style;
    }
    return self;
}

-(void)setupUI
{
    self.backgroundColor = HEXCOLOR(0xffffff);
    [self addSubview:self.bottomline];
    [self addSubview:self.inputTextField];
    [self.inputTextField setDelegate:self];
    [self addSubview:self.inputTileLabel];
}


-(NSString *)inputTile
{
    return self.inputTileLabel.text;
}

-(void)setInputTile:(NSString *)inputTile
{
    [self.inputTileLabel setText:inputTile];
}

-(NSString *)inputValue
{
    if (self.formInputStyle == MTBCYFormInputStyleNormal) {
        return self.inputTextField.text;
    }
    return nil;
}

-(void)setInputValue:(NSString *)inputValue
{
    if (self.formInputStyle == MTBCYFormInputStyleNormal) {
        [self.inputTextField setText:inputValue];
    }
}

-(NSString *)inputplaceholderText
{
    return self.inputTextField.placeholder;
}

-(void)setInputplaceholderText:(NSString *)inputplaceholderText
{
    self.inputTextField.placeholder = inputplaceholderText;
}

-(void)updateConstraints
{
//    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@45);
//    }];
    [self.inputTileLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(15);
        make.height.equalTo(@16);
        make.width.equalTo(@80);
    }];
    
    if (self.formInputStyle == MTBCYFormInputStyleNormal ) {
        [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self.inputTileLabel.mas_right);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@16);
        }];
    }
    
    [self.bottomline mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self);
    }];
    
    [super updateConstraints];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)resignFirstResponder
{
    [super resignFirstResponder];
    [self.inputTextField resignFirstResponder];
}

-(UIView *)bottomline
{
    if (_bottomline == nil) {
        _bottomline = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomline.backgroundColor = HEXCOLOR(0xe7e7e7);
    }
    return _bottomline;
}

-(UILabel *)inputTileLabel
{
    if (_inputTileLabel == nil) {
        _inputTileLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _inputTileLabel.textColor = HEXCOLOR(0x333333);
        _inputTileLabel.font = Font(16);
    }
    return _inputTileLabel;
}

-(UITextField *)inputTextField
{
    if (_inputTextField == nil) {
        _inputTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        _inputTextField.textColor = HEXCOLOR(0x333333);
        _inputTextField.font = Font(16);
        [_inputTextField setValue:HEXCOLOR(0xcccccc) forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _inputTextField;
}

@end
