//
//  GBYCameraOverlayView.h
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/11.
//

#import <UIKit/UIKit.h>
#import "GBYCameraTopContainView.h"
#import "GBYCameraBottomContainView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GBYCameraOverlayViewDelegate <NSObject>

/// 闪光灯
- (void)flashButtonDelegate:(BOOL)switchState;

/// 取消按钮
- (void)cancleButtonDelegate;

/// 拍摄按钮
- (void)photoShootButtonDelegate;

/// 继续拍照按钮
- (void)photoShootContinueButtonDelegate;

/// 前后切换
- (void)rotatingButtonDelegate;

/// 使用照片
- (void)usePhotoButtonDelegate;

@end

@interface GBYCameraOverlayView : UIView

@property (nonatomic, weak) id<GBYCameraOverlayViewDelegate> delegate;

@property (nonatomic, strong) GBYCameraTopContainView *topContainerView;

@property (nonatomic, strong) UIImageView *cameraOverlayView;

@property (nonatomic, strong) GBYCameraBottomContainView *bottomContainView;

@end

NS_ASSUME_NONNULL_END
