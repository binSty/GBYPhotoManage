//
//  UIView+GBYToastView.m
//  GBYTableViewRefresh
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#import "UIView+GBYToastView.h"

@implementation UIView (GBYToastView)

- (void)showLoadingView {
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    style.messageAlignment = NSTextAlignmentCenter;
    [CSToastManager setSharedStyle:style];
    [CSToastManager sharedStyle].fadeDuration = 0;
    [[CSToastManager sharedStyle] setActivitySize:CGSizeMake(80, 80)];
    [self makeToastActivity:CSToastPositionCenter];
}

- (void)showTipToast:(NSString *)message delay:(CGFloat)delay{
    [self hideLoadingView];
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    style.verticalPadding = 12;
    style.horizontalPadding = 16;
    style.messageAlignment = NSTextAlignmentCenter;
    [CSToastManager setSharedStyle:style];
    [CSToastManager sharedStyle].fadeDuration = 0;
    [self makeToast:message duration:delay position:CSToastPositionCenter];
}

- (void)hideLoadingView {
    [self hideToast];
    [self hideToastActivity];
}

@end
