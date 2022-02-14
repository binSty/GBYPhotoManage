//
//  GBYHomePhotoCollectionViewCell.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/10.
//

#import "GBYHomePhotoCollectionViewCell.h"

@implementation GBYHomePhotoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setCellInit];
    }
    return self;
}

- (void)setCellInit {
    self.cellPhotoImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    self.cellPhotoImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.cellPhotoImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.cellPhotoImageView];
}

@end
