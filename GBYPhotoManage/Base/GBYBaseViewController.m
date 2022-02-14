//
//  GBYBaseViewController.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#import "GBYBaseViewController.h"

@interface GBYBaseViewController ()

@end

@implementation GBYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (@available(iOS 13.0, *)) {
        if (viewControllerToPresent.modalPresentationStyle == UIModalPresentationPageSheet || viewControllerToPresent.modalPresentationStyle == UIModalPresentationAutomatic){
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    } else {
        // Fallback on earlier versions
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
