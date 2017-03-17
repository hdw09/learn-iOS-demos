//
//  MTVRCameraImagesView.h
//  Pods
//
//  Created by David on 2017/1/23.
//
//

#import <CoreMotion/CoreMotion.h>
#import <OpenGLES/ES1/gl.h>
#import <GLKit/GLKit.h>
#import "MTVRCameraImage.h"

@interface MTVRCameraImagesView : GLKView

/// 当前的视角
@property (nonatomic, assign) GLKVector3 lookVector;
@property (nonatomic, assign) CGFloat lookAzimuth;
@property (nonatomic, assign) CGFloat lookAltitude;


- (void)draw:(NSArray<MTVRCameraImage *> *)cameraImagesArray;
- (CGPoint)screenLocationFromVector:(GLKVector3)vector;
- (GLKVector3)vectorFromScreenLocation:(CGPoint)point;
- (BOOL)computeScreenLocation:(CGPoint*)location fromVector:(GLKVector3)vector;

@end
