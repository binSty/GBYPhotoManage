//
//  GBYHomeDetailHeaderView.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#import "GBYHomeDetailHeaderView.h"

@implementation GBYHomeDetailHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self _setHeaderInit];
    }
    return self;
}

- (void)_setHeaderInit {
    
    self.separatorTopView = [[UIView alloc] init];
    self.separatorTopView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self addSubview:self.separatorTopView];
    
    self.arrowImg = [[UIImageView alloc] init];
    self.arrowImg.image = [UIImage imageNamed:@"arrow"];
    self.arrowImg.contentMode = UIViewContentModeScaleAspectFill;
    self.arrowImg.clipsToBounds = YES;
    [self addSubview:self.arrowImg];
    
    self.headerTitleLabel = [[UILabel alloc] init];
    self.headerTitleLabel.font = UIDEFAULTFONTSIZE(14);
    self.headerTitleLabel.textColor = UIColorFromRGB(0x333333);
    [self addSubview:self.headerTitleLabel];
    
    [self.separatorTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.mas_equalTo(self);
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(1*kYY);
    }];
    
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*kXX);
        make.width.mas_equalTo(22*kYY);
        make.height.mas_equalTo(22*kYY);
    }];
    [self.headerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15*kXX);
        make.width.mas_equalTo(kScreenW - 80*kXX);
        make.height.mas_equalTo(30*kYY);
    }];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesClick)];
    [self addGestureRecognizer:tapGes];
}

- (void)setSectionModel:(GBYHomeDetailModel *)sectionModel {
    _sectionModel = sectionModel;
    
    self.headerTitleLabel.text = sectionModel.sectionTitle;
    self.arrowImg.transform = self.sectionModel.isCellOpen ? CGAffineTransformMakeRotation(-M_PI) : CGAffineTransformMakeRotation(0);
}

- (void)tapGesClick {
    self.sectionModel.isCellOpen = !self.sectionModel.isCellOpen;
    if (self.headerTapClickBlock) {
        self.headerTapClickBlock();
    }
}

@end
