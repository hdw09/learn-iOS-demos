//
//  MTVRCameraIndicatorView.m
//  Pods
//
//  Created by David on 2017/2/7.
//
//

#import "MTVRCameraIndicatorView.h"

static CGFloat kMTVRCameraIndicatorViewRadius = 50;
static CGFloat kMTVRCameraIndicatorViewPointMaxSize = 40;
static CGFloat kMTVRCameraIndicatorViewPointMinSize = 10;

@interface MTVRCameraIndicatorView()

@property (nonatomic, strong) CAShapeLayer *ringLayer;
@property (nonatomic, strong) CAShapeLayer *pointLayer;

@end

@implementation MTVRCameraIndicatorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.layer addSublayer:self.ringLayer];
        [self.layer addSublayer:self.pointLayer];
    }
    return self;
}

- (void)setPointPosition:(CGPoint)point
{
    point.x = point.x < 0 ? 0 : point.x;
    point.x = point.x > SCREEN_WIDTH ? SCREEN_WIDTH : point.x;
    point.y = point.y < 0 ? 0 : point.y;
    point.y = point.y > SCREEN_HEIGHT ? SCREEN_HEIGHT : point.y;
    self.distance = sqrt((point.x - SCREEN_WIDTH / 2) * (point.x - SCREEN_WIDTH / 2) + (point.y - SCREEN_HEIGHT / 2) * (point.y - SCREEN_HEIGHT / 2));
    CGFloat radius = kMTVRCameraIndicatorViewPointMinSize;
    if (self.distance <= kMTVRCameraIndicatorViewRadius) {
        radius = (kMTVRCameraIndicatorViewRadius - self.distance) * (kMTVRCameraIndicatorViewPointMaxSize - kMTVRCameraIndicatorViewPointMinSize) / kMTVRCameraIndicatorViewRadius + kMTVRCameraIndicatorViewPointMinSize;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                        radius:radius
                                                    startAngle:0
                                                      endAngle:2 * M_PI
                                                     clockwise:YES];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.pointLayer.path = path.CGPath;
    self.pointLayer.frame = CGRectMake(point.x - radius, point.y - radius, 2 * radius, 2 * radius);
    [CATransaction commit];
}

- (CAShapeLayer *)ringLayer
{
    if (!_ringLayer) {
        _ringLayer = [CAShapeLayer layer];
        
        CGPathRef path = [[UIBezierPath bezierPathWithArcCenter:CGPointMake(kMTVRCameraIndicatorViewRadius, kMTVRCameraIndicatorViewRadius)
                                                         radius:kMTVRCameraIndicatorViewRadius
                                                     startAngle:0
                                                       endAngle:2 * M_PI
                                                      clockwise:YES] CGPath];
        _ringLayer.path = path;
        _ringLayer.frame = CGRectMake(SCREEN_WIDTH / 2 - kMTVRCameraIndicatorViewRadius, SCREEN_HEIGHT / 2 - kMTVRCameraIndicatorViewRadius, 2 * kMTVRCameraIndicatorViewRadius, 2 * kMTVRCameraIndicatorViewRadius);
        _ringLayer.fillColor = [[UIColor clearColor] CGColor];
        _ringLayer.strokeColor = IMERCHANT_GREEN.CGColor;
        _ringLayer.opacity = 0.6;
        _ringLayer.lineWidth = 5.0f;
    }
    return _ringLayer;
}

- (CAShapeLayer *)pointLayer
{
    if (!_pointLayer) {
        _pointLayer = [CAShapeLayer layer];
        _pointLayer.strokeColor = [UIColor clearColor].CGColor;
        _pointLayer.lineWidth = 1;
        _pointLayer.fillColor = IMERCHANT_GREEN.CGColor;
        _pointLayer.opacity = 0.6;
        
    }
    return _pointLayer;
}

@end
