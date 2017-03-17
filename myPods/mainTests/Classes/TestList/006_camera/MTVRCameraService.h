//
//  MTVRCameraService.h
//  Pods
//
//  Created by David on 2017/2/7.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol MTVRCameraServiceDelegate <NSObject>

- (void)deviceConfigurationFailedWithError:(NSError *)error;
- (void)mediaCaptureFailedWithError:(NSError *)error;
- (void)assetLibraryWriteFailedWithError:(NSError *)error;
- (void)captureImage:(UIImage *)image number:(NSInteger) number;

@end

@interface MTVRCameraService : NSObject

@property (nonatomic, weak) id<MTVRCameraServiceDelegate> delegate;
@property (nonatomic, strong, readonly) AVCaptureSession *captureSession;

// Session Configuration
- (BOOL)setupSession:(NSError **)error;
- (void)startSession;
- (void)stopSession;

// Still Image Capture
- (void)captureStillImage:(NSInteger) number;

@end
