//
//  GBYCameraTopContainView.h
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GBYCameraTopContainView : UIView

@property (nonatomic, copy) dispatch_block_t flashButtonBlock;

@property (nonatomic, strong) UIButton *flashButton;

@end

NS_ASSUME_NONNULL_END
