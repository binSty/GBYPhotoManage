//
//  GBYCameraPickerController.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/11.
//

#import "GBYCameraPickerController.h"
#import "GBYCameraOverlayView.h"

@interface GBYCameraPickerController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, GBYCameraOverlayViewDelegate>

@property (nonatomic, strong) GBYCameraOverlayView *overlayView;

@end

@implementation GBYCameraPickerController

- (instancetype)initWithParam {
    self = [super init];
    if (self) {
        [self cameraInit];
    }
    return self;
}

- (void)cameraInit {
    /// 需要重新添加init方法，在viewDidLoad实现会崩溃
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    self.delegate = self;
    // set to NO to hide all standard camera UI. default is YES
    // 隐藏系统相机控件
    self.showsCameraControls = NO;
    self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    // 自定义相机视图控件
    self.cameraOverlayView = self.overlayView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGSize previewSize = self.overlayView.cameraOverlayView.bounds.size;
    CGFloat offsety = 0.0;
    CGFloat scale = 1.0;
    if ((previewSize.height / previewSize.width) > (4.0 / 3.0)) {
        scale = 3.0 * previewSize.height / (4.0 * UIScreen.mainScreen.bounds.size.width);
        offsety = previewSize.height * (scale - 1) * 0.5;
    }
    self.cameraViewTransform = CGAffineTransformMakeTranslation(0, CGRectGetMinY(self.overlayView.cameraOverlayView.frame) + offsety);
    self.cameraViewTransform = CGAffineTransformScale(self.cameraViewTransform, scale, scale);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    if (self.isEditing) {
        /// 编辑后的图
        UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
        self.overlayView.cameraOverlayView.image = editedImage;
    } else {
        /// 原图
        UIImage *originalImage = (UIImage *)info[UIImagePickerControllerOriginalImage];
        self.overlayView.cameraOverlayView.image = originalImage;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

#pragma mark --
#pragma mark -- GBYCameraOverlayViewDelegate
- (void)flashButtonDelegate:(BOOL)switchState {
    if (switchState) {
        self.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    } else {
        self.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    }
}

- (void)rotatingButtonDelegate {
    if (self.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    } else {
        self.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
}

- (void)cancleButtonDelegate {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoShootButtonDelegate {
    [self takePicture];
    [self defaultStateButton];
}

- (void)photoShootContinueButtonDelegate {
    /// 保存本地图片
    /// self.overlayView.cameraOverlayView.image
    /// 更改状态
    self.overlayView.cameraOverlayView.image = [UIImage new];
    [self changeStateButton];
}

- (void)usePhotoButtonDelegate {
    /// 保存本地图片
    /// self.overlayView.cameraOverlayView.image
    self.overlayView.cameraOverlayView.image = [UIImage new];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)defaultStateButton {
    self.overlayView.bottomContainView.photoShootButton.hidden = YES;
    self.overlayView.bottomContainView.rotatingButton.hidden = YES;
    self.overlayView.bottomContainView.photoShootContinueButton.hidden = NO;
    self.overlayView.bottomContainView.userPhotoButton.hidden = NO;
}

- (void)changeStateButton {
    self.overlayView.bottomContainView.photoShootButton.hidden = NO;
    self.overlayView.bottomContainView.rotatingButton.hidden = NO;
    self.overlayView.bottomContainView.photoShootContinueButton.hidden = YES;
    self.overlayView.bottomContainView.userPhotoButton.hidden = YES;
}


#pragma mark --
#pragma mark -- lazy init
- (GBYCameraOverlayView *)overlayView {
    if (!_overlayView) {
        _overlayView = [[GBYCameraOverlayView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _overlayView.delegate = self;
    }
    return _overlayView;
}

@end
