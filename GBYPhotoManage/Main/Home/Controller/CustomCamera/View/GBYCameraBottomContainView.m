//
//  GBYCameraBottomContainView.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/14.
//

#import "GBYCameraBottomContainView.h"

@implementation GBYCameraBottomContainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cancleButton];
        [self addSubview:self.photoShootButton];
        [self addSubview:self.rotatingButton];
        [self addSubview:self.photoShootContinueButton];
        [self addSubview:self.userPhotoButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15*kXX);
        make.width.height.mas_equalTo(40*kYY);
    }];
    
    [self.photoShootButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.height.mas_equalTo(40*kYY);
        make.width.mas_equalTo(80*kYY);
    }];
    
    [self.rotatingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*kXX);
        make.height.mas_equalTo(40*kYY);
        make.width.mas_equalTo(80*kYY);
    }];
    
    [self.photoShootContinueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.height.mas_equalTo(40*kYY);
        make.width.mas_equalTo(80*kYY);
    }];
    
    [self.userPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*kXX);
        make.height.mas_equalTo(40*kYY);
        make.width.mas_equalTo(80*kYY);
    }];
}

- (void)cancleButtonClick:(UIButton *)sender {
    if (self.cancleButtonBlock) {
        self.cancleButtonBlock();
    }
}

- (void)photoShootButtonClick:(UIButton *)sender {
    if (self.photoShootButtonBlock) {
        self.photoShootButtonBlock();
    }
}

- (void)rotatingButtonClick:(UIButton *)sender {
    if (self.rotatingButtonBlock) {
        self.rotatingButtonBlock();
    }
}

- (void)photoShootContinueButtonClick:(UIButton *)sender {
    if (self.photoShootContinueButtonBlock) {
        self.photoShootContinueButtonBlock();
    }
}

- (void)userPhotoButtonClick:(UIButton *)sender {
    if (self.userPhotoButtonBlock) {
        self.userPhotoButtonBlock();
    }
}

- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [[UIButton alloc] init];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

- (UIButton *)photoShootButton {
    if (!_photoShootButton) {
        _photoShootButton = [[UIButton alloc] init];
        [_photoShootButton setImage:[UIImage imageNamed:@"photoShoot"] forState:UIControlStateNormal];
        _photoShootButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _photoShootButton.imageView.clipsToBounds = YES;
        _photoShootButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_photoShootButton addTarget:self action:@selector(photoShootButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoShootButton;
}

- (UIButton *)rotatingButton {
    if (!_rotatingButton) {
        _rotatingButton = [[UIButton alloc] init];
        [_rotatingButton setImage:[UIImage imageNamed:@"ratatingButton"] forState:UIControlStateNormal];
        [_rotatingButton addTarget:self action:@selector(rotatingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _rotatingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _rotatingButton;
}

- (UIButton *)photoShootContinueButton {
    if (!_photoShootContinueButton) {
        _photoShootContinueButton = [[UIButton alloc] init];
        [_photoShootContinueButton setTitle:@"继续拍照" forState:UIControlStateNormal];
        _photoShootContinueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _photoShootContinueButton.hidden = YES;
        [_photoShootContinueButton addTarget:self action:@selector(photoShootContinueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoShootContinueButton;
}

- (UIButton *)userPhotoButton {
    if (!_userPhotoButton) {
        _userPhotoButton = [[UIButton alloc] init];
        [_userPhotoButton setTitle:@"使用照片" forState:UIControlStateNormal];
        _userPhotoButton.hidden = YES;
        [_userPhotoButton addTarget:self action:@selector(userPhotoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _userPhotoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _userPhotoButton;
}

@end
