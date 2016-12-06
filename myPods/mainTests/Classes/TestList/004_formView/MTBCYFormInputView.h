//
//  MTBCYFormInputView.h
//  Pods
//
//  Created by David on 2016/10/20.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MTBCYFormInputStyle){
    MTBCYFormInputStyleNormal,
    MTBCYFormInputStyleMoney,
    MTBCYFormInputStyleCallback,
    MTBCYFormInputStyleRadio,
};

@interface MTBCYFormInputView : UIView
@property (nonatomic, copy) NSString *inputTile;
@property (nonatomic, copy) NSString *inputValue;
@property (nonatomic, copy) NSString *inputplaceholderText;

-(instancetype)initWithInputStyle:(MTBCYFormInputStyle)style;

-(void)resignFirstResponder;

@end
