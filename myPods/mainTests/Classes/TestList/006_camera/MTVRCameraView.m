//
//  MTVRCameraView.m
//  Pods
//
//  Created by David on 2017/2/6.
//
//

#import "MTVRCameraView.h"

@implementation MTVRCameraView

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession*)session
{
    return [(AVCaptureVideoPreviewLayer*)self.layer session];
}

- (void)setSession:(AVCaptureSession *)session
{
    [(AVCaptureVideoPreviewLayer*)self.layer setSession:session];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *borderLayer = [[CALayer alloc] init];
        borderLayer.frame = frame;
        borderLayer.borderWidth = 2;
        borderLayer.borderColor = IMERCHANT_GREEN.CGColor;
        [self.layer addSublayer:borderLayer];
    }
    return self;
}

@end
