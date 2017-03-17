//
//  MTVRCameraViewModel.m
//  Pods
//
//  Created by David on 2017/2/6.
//
//

#import "MTVRCameraViewModel.h"

#define elevationFirst M_PI / 6
#define elevationSecond M_PI / 3

@implementation MTVRCameraViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cameraImagesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addImage:(UIImage *)image number:(NSInteger)number
{
    NSDictionary *tempDictionary = [self fetchNumberPositionArray][number];
    MTVRCameraImage *cameraImage = [[MTVRCameraImage alloc] initWithAzimuth:[tempDictionary[@"azimuth"] floatValue] altitude:[tempDictionary[@"altitude"] floatValue]];
    [cameraImage swapTextureWithImage:image];
    [self.cameraImagesArray addObject:cameraImage];
}

- (NSDictionary *)getNextLookVector
{
    if (self.cameraImagesArray.count >= [self fetchNumberPositionArray].count) {
        return nil;
    }
    return [self fetchNumberPositionArray][self.cameraImagesArray.count];
}

- (NSArray *)fetchNumberPositionArray
{
    return @[
             @{@"azimuth":@(M_PI / 6 * 0),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 1),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 2),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 3),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 4),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 5),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 6),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 7),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 8),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 9),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 10),
               @"altitude":@0},
             @{@"azimuth":@(M_PI / 6 * 11),
               @"altitude":@0},
             
             @{@"azimuth":@(2 * M_PI / 9 * 0),
               @"altitude":@(elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 1),
               @"altitude":@(elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 2),
               @"altitude":@(elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 3),
               @"altitude":@(elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 4),
               @"altitude":@(elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 5),
               @"altitude":@(elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 6),
               @"altitude":@(elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 7),
               @"altitude":@(elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 8),
               @"altitude":@(elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 9),
               @"altitude":@(elevationFirst)},
             
             @{@"azimuth":@(2 * M_PI / 9 * 0),
               @"altitude":@(-elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 1),
               @"altitude":@(-elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 2),
               @"altitude":@(-elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 3),
               @"altitude":@(-elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 4),
               @"altitude":@(-elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 5),
               @"altitude":@(-elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 6),
               @"altitude":@(-elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 7),
               @"altitude":@(-elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 8),
               @"altitude":@(-elevationFirst)},
             @{@"azimuth":@(2 * M_PI / 9 * 9),
               @"altitude":@(-elevationFirst)},
             
             @{@"azimuth":@(M_PI / 2 * 0),
               @"altitude":@(elevationSecond)},
             @{@"azimuth":@(M_PI / 2 * 1),
               @"altitude":@(elevationSecond)},
             @{@"azimuth":@(M_PI / 2 * 2),
               @"altitude":@(elevationSecond)},
             @{@"azimuth":@(M_PI / 2 * 3),
               @"altitude":@(elevationSecond)},
             
             @{@"azimuth":@(M_PI / 2 * 0),
               @"altitude":@(-elevationSecond)},
             @{@"azimuth":@(M_PI / 2 * 1),
               @"altitude":@(-elevationSecond)},
             @{@"azimuth":@(M_PI / 2 * 2),
               @"altitude":@(-elevationSecond)},
             @{@"azimuth":@(M_PI / 2 * 3),
               @"altitude":@(-elevationSecond)}
             ];
}

@end
