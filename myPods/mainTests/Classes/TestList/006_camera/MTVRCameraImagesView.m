//
//  MTVRCameraImagesView.m
//  Pods
//
//  Created by David on 2017/1/23.
//
//

#import "MTVRCameraImagesView.h"
#import "MTVRCameraImage.h"

#define FPS 60
#define FOV_MIN 1
#define FOV_MAX 155
#define Z_NEAR 0.1f
#define Z_FAR 100.0f


static GLfloat circlePoints[64*3];

@interface MTVRCameraImagesView()

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, assign) CGFloat aspectRatio;
@property (nonatomic, assign) CGFloat fieldOfView;

@property (nonatomic, assign) GLKMatrix4 projectionMatrix;
@property (nonatomic, assign) GLKMatrix4 attitudeMatrix;
@property (nonatomic, assign) GLKMatrix4 offsetMatrix;

@property (nonatomic, strong) MTVRCameraImage *sphere;

@end

@implementation MTVRCameraImagesView

#pragma mark -- 初始化配置

- (instancetype)init
{
    return [self initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    [EAGLContext setCurrentContext:context];
    self.context = context;
    return [self initWithFrame:frame context:context];
}

- (instancetype)initWithFrame:(CGRect)frame context:(EAGLContext *)context
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDevice];
        [self initOpenGL:context];
    }
    return self;
}

- (void)initDevice
{
    self.motionManager = [[CMMotionManager alloc] init];
    if (self.motionManager.isDeviceMotionAvailable) {
        [self.motionManager startDeviceMotionUpdates];
    }
    self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchHandler:)];
    [self.pinchGesture setEnabled:NO];
    [self addGestureRecognizer:self.pinchGesture];
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.panGesture setMaximumNumberOfTouches:1];
    [self.panGesture setEnabled:NO];
    [self addGestureRecognizer:self.panGesture];
}

- (void)initOpenGL:(EAGLContext*)context{
    [(CAEAGLLayer*)self.layer setOpaque:NO];
    self.aspectRatio = self.frame.size.width / self.frame.size.height;
    self.fieldOfView = 45 + 45 * atanf(_aspectRatio);
    [self rebuildProjectionMatrix];
    self.attitudeMatrix = GLKMatrix4Identity;
    self.offsetMatrix = GLKMatrix4Identity;
    [self customGL];
    [self makeLatitudeLines];
}

- (void)makeLatitudeLines
{
    for(int i = 0; i < 64; i++){
        circlePoints[i*3+0] = -sinf(M_PI*2/64.0f*i);
        circlePoints[i*3+1] = 0.0f;
        circlePoints[i*3+2] = cosf(M_PI*2/64.0f*i);
    }
}

- (void)customGL
{
    glMatrixMode(GL_MODELVIEW);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}

- (void)rebuildProjectionMatrix
{
    glMatrixMode(GL_PROJECTION);//对投影矩阵应用随后的矩阵操作
    glLoadIdentity();
    GLfloat frustum = Z_NEAR * tanf(_fieldOfView * 0.00872664625997);  // pi/180/2
    self.projectionMatrix = GLKMatrix4MakeFrustum(-frustum, frustum, -frustum/_aspectRatio,
                                                  frustum/_aspectRatio, Z_NEAR, Z_FAR);
    glMultMatrixf(self.projectionMatrix.m);
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    glMatrixMode(GL_MODELVIEW);//对模型视景矩阵堆栈应用随后的矩阵操作.
}

- (void)dealloc
{
    [self.motionManager stopDeviceMotionUpdates];
    [EAGLContext setCurrentContext:nil];
}

#pragma mark -- 逻辑处理

- (GLKMatrix4)getDeviceMotionManagerMatrix
{
    if ([self.motionManager isDeviceMotionActive]) {
        CMRotationMatrix a = [[[self.motionManager deviceMotion] attitude] rotationMatrix];
        return GLKMatrix4Make( a.m11, a.m21, a.m31, 0.0f,
                              a.m13, a.m23, a.m33, 0.0f,
                              -a.m12,-a.m22,-a.m32, 0.0f,
                              0.0f , 0.0f , 0.0f , 1.0f);
    }
    return GLKMatrix4Identity;
}

- (void)updateLook
{
    self.lookVector = GLKVector3Make(-self.attitudeMatrix.m02,
                                 -self.attitudeMatrix.m12,
                                 -self.attitudeMatrix.m22);
    self.lookAzimuth = atan2f(self.lookVector.x, -self.lookVector.z);
    self.lookAltitude = asinf(self.lookVector.y);
}

- (GLKVector3)vectorFromScreenLocation:(CGPoint)point
{
    return [self vectorFromScreenLocation:point inAttitude:_attitudeMatrix];
}

- (GLKVector3)vectorFromScreenLocation:(CGPoint)point inAttitude:(GLKMatrix4)matrix
{
    GLKMatrix4 inverse = GLKMatrix4Invert(GLKMatrix4Multiply(_projectionMatrix, matrix), nil);
    GLKVector4 screen = GLKVector4Make(2.0*(point.x/self.frame.size.width-.5),
                                       2.0*(.5-point.y/self.frame.size.height),
                                       1.0, 1.0);
    GLKVector4 vec = GLKMatrix4MultiplyVector4(inverse, screen);
    return GLKVector3Normalize(GLKVector3Make(vec.x, vec.y, vec.z));
}

- (CGPoint)screenLocationFromVector:(GLKVector3)vector
{
    GLKMatrix4 matrix = GLKMatrix4Multiply(_projectionMatrix, _attitudeMatrix);
    GLKVector3 screenVector = GLKMatrix4MultiplyVector3(matrix, vector);
    int flag = screenVector.z > 0 ? 1 : -1;
    screenVector.z = sqrtf(screenVector.z * screenVector.z) < 0.001 ? flag * 0.001 :screenVector.z;
    return CGPointMake( (screenVector.x/screenVector.z/2.0 + 0.5) * self.frame.size.width,
                       (0.5-screenVector.y/screenVector.z/2) * self.frame.size.height );
}

- (BOOL)computeScreenLocation:(CGPoint*)location fromVector:(GLKVector3)vector
{
    return [self computeScreenLocation:location fromVector:vector inAttitude:_attitudeMatrix];
}

- (BOOL)computeScreenLocation:(CGPoint*)location fromVector:(GLKVector3)vector inAttitude:(GLKMatrix4)matrix
{
    //This method returns whether the point is before or behind the screen.
    GLKVector4 screenVector;
    GLKVector4 vector4;
    if(location == NULL)
        return NO;
    matrix = GLKMatrix4Multiply(_projectionMatrix, matrix);
    vector4 = GLKVector4Make(vector.x, vector.y, vector.z, 1);
    screenVector = GLKMatrix4MultiplyVector4(matrix, vector4);
    int flag = screenVector.z > 0 ? 1 : -1;
    screenVector.w = screenVector.w * screenVector.w < 0.000001 ? flag * 0.001 :screenVector.w;
    location->x = (screenVector.x/screenVector.w/2.0 + 0.5) * self.frame.size.width;
    location->y = (0.5-screenVector.y/screenVector.w/2) * self.frame.size.height;
    return (screenVector.z >= 0);
}

#pragma mark -- 事件处理

- (void)pinchHandler:(UIPinchGestureRecognizer*)sender
{
    
}

- (void)panHandler:(UIPanGestureRecognizer*)sender
{
    
}

- (void)draw:(NSArray<MTVRCameraImage *> *)cameraImagesArray
{
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    glPushMatrix();
    [self renderScene:cameraImagesArray];
    glPopMatrix();
    
}

- (void)renderScene:(NSArray<MTVRCameraImage *> *)cameraImagesArray
{
    static GLfloat whiteColor[] = {1.0f, 1.0f, 1.0f, 1.0f};
    static GLfloat clearColor[] = {0.0f, 0.0f, 0.0f, 0.0f};
    self.attitudeMatrix = GLKMatrix4Multiply([self getDeviceMotionManagerMatrix], self.offsetMatrix);
    [self updateLook];
    glMultMatrixf(self.attitudeMatrix.m);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, whiteColor);
    [self drawCameraImages:cameraImagesArray];
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, clearColor);

    [self drawCoordinateLines];
    
}

- (void)drawCameraImages:(NSArray<MTVRCameraImage *> *)cameraImagesArray
{
    for (MTVRCameraImage *image in cameraImagesArray) {
        [image execute];
    }
}

- (void)drawCoordinateLines
{
    glColor4f(0.3f, 0.3f, 0.3f, 0.5f);
    GLKVector3 touchLocation;
    glLineWidth(2.0f);
    for (int i = -9; i< 10; i+=3) {
        float scale = sqrtf(1 - powf(i * 0.1 ,2));
        glPushMatrix();
        glScalef(scale, 1.0f, scale);
        glTranslatef(0, i * 0.1, 0);
        glDisableClientState(GL_NORMAL_ARRAY);
        glEnableClientState(GL_VERTEX_ARRAY);
        glVertexPointer(3, GL_FLOAT, 0, circlePoints);
        glDrawArrays(GL_LINE_LOOP, 0, 64);
        glDisableClientState(GL_VERTEX_ARRAY);
        glPopMatrix();
    }
    for (int i = -6; i< 6; i++) {
        glPushMatrix();
        glRotatef(30 * i , 0, 1, 0);
        glRotatef(90, 1, 0, 0);
        glDisableClientState(GL_NORMAL_ARRAY);
        glEnableClientState(GL_VERTEX_ARRAY);
        glVertexPointer(3, GL_FLOAT, 0, circlePoints);
        glDrawArrays(GL_LINE_STRIP, 0, 64);
        glDisableClientState(GL_VERTEX_ARRAY);
        glPopMatrix();
    }
    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
}

@end
