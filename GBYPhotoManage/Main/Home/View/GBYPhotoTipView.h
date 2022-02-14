//
//  GBYPhotoTipView.h
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SheetCellActionBlock)(NSInteger indexNum);

@interface GBYPhotoTipView : UIView

@property (nonatomic, copy) SheetCellActionBlock actionBlock;

- (void)showSheetView;

@end

NS_ASSUME_NONNULL_END
