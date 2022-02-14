//
//  UIView+GBYToastView.h
//  GBYTableViewRefresh
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#import <UIKit/UIKit.h>
#import <Toast/Toast.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GBYToastView)

- (void)showLoadingView;
- (void)hideLoadingView;

- (void)showTipToast:(NSString *)message delay:(CGFloat)delay;

@end

NS_ASSUME_NONNULL_END
