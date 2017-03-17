//
//  MTVRCameraPage.m
//  Pods
//
//  Created by David on 2017/1/23.
//
//

#import "MTVRCameraPage.h"
#import "MTVRCameraImagesView.h"
#import "MTVRCameraViewModel.h"
#import "MTVRCameraView.h"
#import "MTVRCameraService.h"
#import "MTVRCameraIndicatorView.h"
#import <OpenGLES/ES1/gl.h>

@interface MTVRCameraPage () <MTVRCameraServiceDelegate>

@property (nonatomic, strong) UIButton *closeImageButton;
@property (nonatomic, strong) MTVRCameraImagesView *cameraImagesView;
@property (nonatomic, strong) MTVRCameraView *cameraView;
@property (nonatomic, strong) MTVRCameraService *cameraService;
@property (nonatomic, strong) MTVRCameraIndicatorView *cameraIndicatorView;
@property (nonatomic, strong) MTVRCameraViewModel *viewModel;

@property (nonatomic, assign) BOOL canFetchImage;

@end

@implementation MTVRCameraPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewModel = [[MTVRCameraViewModel alloc] init];
    [self setupUI];
    [self setupCamera];
    [self bindEvent];
    self.canFetchImage = YES;
}

- (void)setupCamera
{
    self.cameraService = [[MTVRCameraService alloc] init];
    NSError *error;
    if ([self.cameraService setupSession:&error]) {
        [self.cameraView setSession:self.cameraService.captureSession];
        [self.cameraService startSession];
        self.cameraService.delegate = self;
    } else {
        /// TODO 展示错误对话框
        NSLog(@"Error: %@", [error localizedDescription]);
    }
}

- (void)setupUI
{
    self.view = self.cameraImagesView;
    [self.view addSubview:self.cameraView];
    [self.view addSubview:self.cameraIndicatorView];
    [self.view addSubview:self.closeImageButton];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    [self.cameraView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@240);
        make.height.equalTo(@320);
    }];
    [self.cameraIndicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.closeImageButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@50);
        make.top.left.equalTo(self.view).offset(15);
    }];
    
    [super updateViewConstraints];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.cameraImagesView draw:self.viewModel.cameraImagesArray];
}

- (void)dealloc
{
    [self.cameraService stopSession];
}

#pragma marks -- 拍摄相关逻辑

- (void)bindEvent
{
    @weakify(self);
    [[RACObserve(self.cameraImagesView, lookAzimuth) skip:50] subscribeNext:^(id x) {
        @strongify(self);
        NSDictionary *dictionary =  [self.viewModel getNextLookVector];
        GLKVector3 vector;
        vector.z = cosf([dictionary[@"azimuth"] floatValue]) * cosf([dictionary[@"altitude"] floatValue]);
        vector.x = sinf([dictionary[@"azimuth"] floatValue]) * cosf([dictionary[@"altitude"] floatValue]);
        vector.y = sinf([dictionary[@"altitude"] floatValue]);
        CGPoint point;
        if (![self.cameraImagesView computeScreenLocation:&point fromVector:vector]) {
            [self.cameraIndicatorView setPointPosition:point];
            if (self.cameraIndicatorView.distance < 4 && self.canFetchImage) {
                self.canFetchImage = NO;
                [self.cameraService captureStillImage:self.viewModel.cameraImagesArray.count];
            }
        }
    }];
}

- (void)captureImage:(UIImage *)image number:(NSInteger)number
{
    if (image) {
        [self.viewModel addImage:image number:number];
    }
    self.canFetchImage = YES;
}

#pragma marks -- 交互事件处理

- (void)closeImageButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma marks -- 懒加载

- (UIButton *)closeImageButton
{
    if (!_closeImageButton) {
        _closeImageButton = [[UIButton alloc] init];
        [_closeImageButton setImage:[MainTestsBundleGeter getImage:@"mtvr_close_page.png"] forState:UIControlStateNormal] ;
        [_closeImageButton addTarget:self action:@selector(closeImageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeImageButton;
}

- (MTVRCameraImagesView *)cameraImagesView
{
    if (!_cameraImagesView) {
        _cameraImagesView = [[MTVRCameraImagesView alloc] init];
    }
    return _cameraImagesView;
}

- (MTVRCameraView *)cameraView
{
    if (!_cameraView) {
        _cameraView = [[MTVRCameraView alloc] initWithFrame:CGRectMake(0, 0, 240, 320)];
    }
    return _cameraView;
}

- (MTVRCameraIndicatorView *)cameraIndicatorView
{
    if (!_cameraIndicatorView) {
        _cameraIndicatorView = [[MTVRCameraIndicatorView alloc] init];
    }
    return _cameraIndicatorView;
}

@end
