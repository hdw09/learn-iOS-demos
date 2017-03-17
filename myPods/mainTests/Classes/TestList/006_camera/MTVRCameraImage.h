//
//  MTVRCameraImage.h
//  Pods
//
//  Created by David on 2017/1/24.
//
//
#import <GLKit/GLKit.h>
#import <OpenGLES/ES1/gl.h>
#import <Foundation/Foundation.h>

@interface MTVRCameraImage : NSObject

@property (nonatomic, assign) GLfloat azimuth;
@property (nonatomic, assign) GLfloat altitude;
@property (nonatomic, assign) NSInteger number;

- (bool)execute;
- (void)swapTextureWithImage:(UIImage *)image;
- (instancetype)initWithAzimuth:(GLfloat)azimuth altitude:(GLfloat)altitude;

@end
