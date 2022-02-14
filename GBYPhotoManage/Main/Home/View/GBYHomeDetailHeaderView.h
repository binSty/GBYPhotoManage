//
//  GBYHomeDetailHeaderView.h
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#import <UIKit/UIKit.h>
#import "GBYHomeDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GBYHomeDetailHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) dispatch_block_t headerTapClickBlock;
@property (nonatomic, strong) GBYHomeDetailModel *sectionModel;
@property (nonatomic, strong) UIView *separatorTopView;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UILabel *headerTitleLabel;

@end

NS_ASSUME_NONNULL_END
