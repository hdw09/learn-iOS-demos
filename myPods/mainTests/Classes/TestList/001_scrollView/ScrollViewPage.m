//
//  ScrollViewPage.m
//  Pods
//
//  Created by David on 16/9/27.
//
//

#import "ScrollViewPage.h"

@interface ScrollViewPage()

@property (nonatomic, strong) UIView *father1;
@property (nonatomic, strong) UIView *child1;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, strong) UITextView *show;

@property (nonatomic, strong) UIImageView *upImageView;
@property (nonatomic, strong) UIImageView *downImageView;

@end

@implementation ScrollViewPage

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = UIColorFromRGB(0xf1f1f1);
    [self test1];
    [self test2];
    [self test3];
    [self bindShow];
}

- (void)test1
{
    _father1 = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 150, 100)];
    _father1.backgroundColor = UIColorFromRGB(0xffdefa);
    
    _child1 = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 60, 30)];
    _child1.backgroundColor = UIColorFromRGB(0x82fcdf);
    self.father1.bounds = CGRectMake(20, 20, 150, 100);
    [self.father1 addSubview:_child1];
    
    [self.view addSubview:_father1];
    // 总结：
    // 1. 视图的 frame 和 bounds 矩形的大小总是一样. 单独改变frame或bounds的宽高另一个的宽高会同时被改变
    // 2. 子视图可以超出父视图的范围显示
    // 3. 总是在bounds上面绘图，绘制完成把长为L宽为W的绘图大小对其到frame上，所以有：
    //    CompositedPosition.x = View.frame.origin.x - Superview.bounds.origin.x;
    //    CompositedPosition.y = View.frame.origin.y - Superview.bounds.origin.y;
}

- (void)test2
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 280)];
    _scrollView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 700)];
    self.myView.backgroundColor = UIColorFromRGB(0xffffff);
    [self.view addSubview:_scrollView];
    [self.scrollView addSubview:self.myView];
    
    self.scrollView.contentSize = self.myView.bounds.size;
    // 总结：
    // 1. ScrollVie的contentOffset其实就是他的bounds origin
    // 2. contentSize是bound游动的盒子，当盒子比bound还小是游不动的
}

- (void)test3
{
    [self.scrollView addSubview:self.upImageView];
    [self.scrollView addSubview:self.downImageView];
    
    self.upImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 -16, -35, 35, 35);
    self.downImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0-16, self.myView.bounds.size.height, 35, 35);
    
    self.scrollView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}

- (void)bindShow
{
    self.show = [[UITextView alloc]initWithFrame:CGRectMake(190, 20, 180, 100)];
    [self.view addSubview:self.show];
    self.show.font = Font(10);
    
    RAC(self.show,text) = [RACSignal combineLatest:@[[RACObserve(self.scrollView, contentInset) map:^id(id value) {
        return [NSString stringWithFormat:@"contentInset:%@\n",value];
    }],[RACObserve(self.scrollView, contentOffset) map:^id(id value) {
        return [NSString stringWithFormat:@"contentOffset:%@\n",value];
    }],[RACObserve(self.scrollView, contentSize) map:^id(id value) {
        return [NSString stringWithFormat:@"contentSize:%@\n",value];
    }],[RACObserve(self.scrollView, bounds) map:^id(id value) {
        return [NSString stringWithFormat:@"bounds:%@\n",value];
    }]] reduce:(id)^(NSString *str1 , NSString *str2 , NSString *str3, NSString *str4){
        return [NSString stringWithFormat:@"%@%@%@%@",str1,str2,str3,str4];
    }];
}

-(UIImageView *)upImageView
{
    if (!_upImageView) {
        _upImageView = [[UIImageView alloc]init];
        _upImageView.image = [MainTestsBundleGeter getImage:@"scrollViewup.png"];
    }
    return _upImageView;
}

- (UIImageView *)downImageView
{
    if (!_downImageView) {
        _downImageView = [[UIImageView alloc]init];
        _downImageView.image = [MainTestsBundleGeter getImage:@"scrollViewdown.png"];
    }
    return _downImageView;
    
}

@end
