//
//  GBYCameraOverlayView.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/11.
//

#import "GBYCameraOverlayView.h"

@interface GBYCameraOverlayView ()

@property (nonatomic, assign) BOOL falshState;

@end

@implementation GBYCameraOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self controlInit];
    }
    return self;
}

- (void)controlInit {
    
    self.falshState = YES;
    
    @weakify(self);
    self.topContainerView.flashButtonBlock = ^{
        @strongify(self);
        self.falshState = !self.falshState;
        if ([self.delegate respondsToSelector:@selector(flashButtonDelegate:)]) {
            [self.delegate flashButtonDelegate:self.falshState];
        }
    };
    
    self.bottomContainView.cancleButtonBlock = ^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(cancleButtonDelegate)]) {
            [self.delegate cancleButtonDelegate];
        }
    };
    
    self.bottomContainView.photoShootButtonBlock = ^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(photoShootButtonDelegate)]) {
            [self.delegate photoShootButtonDelegate];
        }
    };
    
    self.bottomContainView.rotatingButtonBlock = ^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(rotatingButtonDelegate)]) {
            [self.delegate rotatingButtonDelegate];
        }
    };
    
    self.bottomContainView.photoShootContinueButtonBlock = ^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(photoShootContinueButtonDelegate)]) {
            [self.delegate photoShootContinueButtonDelegate];
        }
    };
    
    self.bottomContainView.userPhotoButtonBlock = ^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(usePhotoButtonDelegate)]) {
            [self.delegate usePhotoButtonDelegate];
        }
    };
    
    [self addSubview:self.topContainerView];
    [self addSubview:self.cameraOverlayView];
    [self addSubview:self.bottomContainView];
}

#pragma mark --
#pragma mark -- lazy init
- (GBYCameraTopContainView *)topContainerView {
    if (!_topContainerView) {
        _topContainerView = [[GBYCameraTopContainView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44*kYY)];
        _topContainerView.backgroundColor = [UIColor blackColor];
    }
    return _topContainerView;
}

- (UIImageView *)cameraOverlayView {
    if (!_cameraOverlayView) {
        _cameraOverlayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44*kYY, kScreenW, kScreenH - BYSafeBottomMagin - 124*kYY)];
        _cameraOverlayView.backgroundColor = [UIColor clearColor];
    }
    return _cameraOverlayView;
}

- (GBYCameraBottomContainView *)bottomContainView {
    if (!_bottomContainView) {
        _bottomContainView = [[GBYCameraBottomContainView alloc] initWithFrame:CGRectMake(0, kScreenH - BYSafeBottomMagin - 80*kYY, kScreenW, 80*kYY)];
        _bottomContainView.backgroundColor = [UIColor blackColor];
    }
    return _bottomContainView;
}

@end
