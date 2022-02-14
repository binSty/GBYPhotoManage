//
//  GBYPhotoTipTableViewCell.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/10.
//

#import "GBYPhotoTipTableViewCell.h"

@implementation GBYPhotoTipTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self cellInit];
    }
    return self;
}

- (void)cellInit {
    
    [self.contentView addSubview:self.cellTitleLb];
    [self.contentView addSubview:self.separatorLineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.cellTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(10*kYY);
    }];
}

- (UILabel *)cellTitleLb {
    if (!_cellTitleLb) {
        _cellTitleLb = [[UILabel alloc] init];
        _cellTitleLb.textColor = [UIColor blackColor];
        _cellTitleLb.font = UIDEFAULTFONTSIZE(14);
        _cellTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _cellTitleLb;
}

- (UIView *)separatorLineView {
    if (!_separatorLineView) {
        _separatorLineView = [[UIView alloc] init];
        _separatorLineView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _separatorLineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
