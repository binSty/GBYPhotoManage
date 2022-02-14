//
//  GBYCameraBottomContainView.h
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GBYCameraBottomContainView : UIView

@property (nonatomic, copy) dispatch_block_t cancleButtonBlock;

@property (nonatomic, copy) dispatch_block_t photoShootButtonBlock;

@property (nonatomic, copy) dispatch_block_t rotatingButtonBlock;

@property (nonatomic, copy) dispatch_block_t photoShootContinueButtonBlock;

@property (nonatomic, copy) dispatch_block_t userPhotoButtonBlock;

@property (nonatomic, strong) UIButton *cancleButton;

/// 拍照按钮
@property (nonatomic, strong) UIButton *photoShootButton;

/// 继续拍照
@property (nonatomic, strong) UIButton *photoShootContinueButton;

/// 切换前后摄像头
@property (nonatomic, strong) UIButton *rotatingButton;

/// 使用照片
@property (nonatomic, strong) UIButton *userPhotoButton;

@end

NS_ASSUME_NONNULL_END
