//
//  MTVRCameraService.m
//  Pods
//
//  Created by David on 2017/2/7.
//
//

#import "MTVRCameraService.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface MTVRCameraService()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, weak) AVCaptureDeviceInput *activeVideoInput;
@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutput;

@end

@implementation MTVRCameraService

- (BOOL)setupSession:(NSError **)error
{
    self.captureSession = [[AVCaptureSession alloc] init];
    // AVCaptureSessionPresetHigh  AVCaptureSessionPreset640x480 AVCaptureSessionPreset1280x720
    self.captureSession.sessionPreset = AVCaptureSessionPreset640x480;
    
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];
    if (videoInput) {
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];
            self.activeVideoInput = videoInput;
        }
    } else {
        return NO;
    }
    
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    self.imageOutput.outputSettings = @{AVVideoCodecKey : AVVideoCodecJPEG};
    
    if ([self.captureSession canAddOutput:self.imageOutput]) {
        [self.captureSession addOutput:self.imageOutput];
    }
    
    return YES;
}

- (void)startSession
{
    if (![self.captureSession isRunning]) {
        dispatch_async([self globalQueue], ^{
            [self.captureSession startRunning];
        });
    }
}

- (void)stopSession
{
    if ([self.captureSession isRunning]) {
        dispatch_async([self globalQueue], ^{
            [self.captureSession stopRunning];
        });
    }
}

- (dispatch_queue_t)globalQueue
{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (void)captureStillImage:(NSInteger) number
{
    AVCaptureConnection *connection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (connection.isVideoOrientationSupported) {
        connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    }
    @weakify(self);
    id handler = ^(CMSampleBufferRef sampleBuffer, NSError *error) {
        @strongify(self);
        if (sampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:sampleBuffer];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            [self writeImageToAssetsLibrary:image];
            //image = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationLeft];
            [self.delegate captureImage:image number:number];
            //[self.delegate captureImage:[self transformRotateImage:image] number:number];
        } else {
            [self.delegate captureImage:nil number:number];
            NSLog(@"NULL sampleBuffer: %@", [error localizedDescription]);
        }
    };
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:connection
                                                  completionHandler:handler];
}

- (UIImage *)transformRotateImage:(UIImage *)image
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 0, image.size.height);//下移
    transform = CGAffineTransformRotate(transform, -M_PI_2);//顺时针旋转-90度
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             
                                             CGImageGetColorSpace(image.CGImage),
                                             
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGContextConcatCTM(ctx, transform);
    CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:UIImageOrientationLeft];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void)writeImageToAssetsLibrary:(UIImage *)image
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    @weakify(self);
    [library writeImageToSavedPhotosAlbum:image.CGImage
                              orientation:(NSInteger)image.imageOrientation
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              if (error) {
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      @strongify(self);
                                      [self.delegate assetLibraryWriteFailedWithError:error];
                                  });
                              }
                          }];
}

@end
