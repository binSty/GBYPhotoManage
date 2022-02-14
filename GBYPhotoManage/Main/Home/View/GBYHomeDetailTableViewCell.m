//
//  GBYHomeDetailTableViewCell.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#import "GBYHomeDetailTableViewCell.h"

@implementation GBYHomeDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _setCellInit];
    }
    return self;
}


- (void)_setCellInit {

    self.cellTextLabel = [[UILabel alloc] init];
    self.cellTextLabel.font = UIDEFAULTFONTSIZE(14);
    self.cellTextLabel.textColor = UIColorFromRGB(0x333333);
    [self.contentView addSubview:self.cellTextLabel];
    
    [self.cellTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5*kYY);
        make.left.equalTo(self.contentView).offset(15*kXX);
        make.width.mas_equalTo(kScreenW - 30*kXX);
        make.height.mas_equalTo(30*kYY);
    }];
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
