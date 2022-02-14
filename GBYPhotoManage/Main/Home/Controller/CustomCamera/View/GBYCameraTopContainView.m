//
//  GBYCameraTopContainView.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/14.
//

#import "GBYCameraTopContainView.h"

@implementation GBYCameraTopContainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.flashButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.flashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10*kXX);
        make.width.height.mas_equalTo(30*kYY);
    }];
}

- (void)flashButtonClick:(UIButton *)sender {
    if (self.flashButtonBlock) {
        self.flashButtonBlock();
    }
}

- (UIButton *)flashButton {
    if (!_flashButton) {
        _flashButton = [[UIButton alloc] init];
        [_flashButton setImage:[UIImage imageNamed:@"flashButton"] forState:UIControlStateNormal];
        [_flashButton addTarget:self action:@selector(flashButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashButton;
    ;
}

@end
