//
//  MTVRCameraViewModel.h
//  Pods
//
//  Created by David on 2017/2/6.
//
//

#import <Foundation/Foundation.h>
#import "MTVRCameraImage.h"

@interface MTVRCameraViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<MTVRCameraImage *> *cameraImagesArray;

- (NSDictionary *)getNextLookVector;
- (void)addImage:(UIImage *)image number:(NSInteger)number;

@end
