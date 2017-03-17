//
//  MTVRCameraImage.m
//  Pods
//
//  Created by David on 2017/1/24.
//
//

#import "MTVRCameraImage.h"

#define IMAGE_SCALING GL_LINEAR  // GL_NEAREST, GL_LINEAR
#define IMAGE_W 0.7
#define IMAGE_H (IMAGE_W * 4 / 3)

@interface MTVRCameraImage()

@property (nonatomic, strong) GLKTextureInfo *textureInfo;
@property (nonatomic, assign) GLfloat *vertexData;

@end

@implementation MTVRCameraImage

- (instancetype)initWithAzimuth:(GLfloat)azimuth altitude:(GLfloat)altitude
{
    self = [super init];
    if (self) {
        self.azimuth = azimuth;
        self.altitude = altitude;
        self.vertexData = (GLfloat *)malloc(sizeof(GLfloat) * 3 * 4);
        float z = - sqrtf( 1 - ((IMAGE_W / 2) * (IMAGE_W / 2) + (IMAGE_H / 2) * (IMAGE_H / 2)));
        
        self.vertexData[0] = IMAGE_W / 2;
        self.vertexData[1] = IMAGE_H / 2;
        self.vertexData[2] = z;
        
        self.vertexData[3] = -(IMAGE_W / 2);
        self.vertexData[4] = IMAGE_H / 2;
        self.vertexData[5] = z;
        
        self.vertexData[6] = -(IMAGE_W / 2);
        self.vertexData[7] = -(IMAGE_H / 2);
        self.vertexData[8] = z;
        
        self.vertexData[9] = IMAGE_W / 2;
        self.vertexData[10] = -(IMAGE_H / 2);
        self.vertexData[11] = z;
    }
    return self;
}

- (void)dealloc
{
    GLuint name = self.textureInfo.name;
    glDeleteTextures(1, &name);
    if(self.vertexData != nil){
        free(self.vertexData);
    }
}

- (bool)execute
{
    glPushMatrix();
        glRotatef(abs(self.azimuth * 180 / M_PI), 0, self.azimuth > 0 ? 1 : -1, 0);
        glRotatef(abs(self.altitude * 180 / M_PI), self.altitude > 0 ? 1 : -1, 0, 0);
        glEnableClientState(GL_NORMAL_ARRAY);
        glEnableClientState(GL_VERTEX_ARRAY);

        glEnable(GL_TEXTURE_2D);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        if(self.textureInfo != 0)
            glBindTexture(GL_TEXTURE_2D, self.textureInfo.name);

        GLfloat coord[] = {0.0,1.0,0.0,0.0,1.0,0.0,1.0,1.0};//{0.0,0.0,0.0,1.0,1.0,1.0,1.0,0.0};
        glTexCoordPointer(2, GL_FLOAT, 0, coord);
        glVertexPointer(3, GL_FLOAT, 0, self.vertexData);
        glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_VERTEX_ARRAY);
        glDisableClientState(GL_NORMAL_ARRAY);
    glPopMatrix();
    return true;
}

- (GLKTextureInfo *)loadTextureFromImage:(UIImage *)image
{
    if(!image) return nil;
    NSError *error;
    GLKTextureInfo *info;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],GLKTextureLoaderOriginBottomLeft, nil];
    info = [GLKTextureLoader textureWithCGImage:image.CGImage options:options error:&error];
    glBindTexture(GL_TEXTURE_2D, info.name);
    return info;
}

- (void)swapTextureWithImage:(UIImage*)image
{
    GLuint name = self.textureInfo.name;
    glDeleteTextures(1, &name);
    self.textureInfo = [self loadTextureFromImage:image];
}

@end
