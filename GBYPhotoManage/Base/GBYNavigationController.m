//
//  GBYNavigationController.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#import "GBYNavigationController.h"
#import "UIImage+ImageColor.h"

@interface GBYNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation GBYNavigationController

//如果项目有导航栏导航栏需要重写此方法，某个单独类定义状态栏颜色才会生效，如果直接隐藏导航栏，不需要写此方法，单独类设置就生效的
/// 当vc在nav中时，上面方法没用，vc中的preferredStatusBarStyle方法根本不用被调用。原因是，[self setNeedsStatusBarAppearanceUpdate]发出后，只会调用navigation controller中的preferredStatusBarStyle方法，vc中的preferredStatusBarStyley方法跟本不会被调用。
- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.interactivePopGestureRecognizer.delegate = self;
    [self navControlStyle];
}

- (void)navControlStyle {
    
    /// 关于navigationBar背景颜色更改及文字大小、颜色修改：
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        NSDictionary *normalTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIColor blackColor],
                                            NSForegroundColorAttributeName,
                                            UIDEFAULTFONTSIZE(17),
                                            NSFontAttributeName,
                                            nil];
        appearance.titleTextAttributes = normalTextAttributes;
        appearance.backgroundColor = UIColorFromRGB(0xF5F5F5); // 设置导航栏背景色
        appearance.shadowImage = [UIImage imageWithColor:[UIColor clearColor]]; // 设置导航栏下边界分割线透明
        self.navigationBar.scrollEdgeAppearance = appearance; // 带scroll滑动的页面
        self.navigationBar.standardAppearance = appearance; // 常规页面。描述导航栏以标准高度显示时要使用的外观属性。
    } else {
        // 导航栏文字
        NSDictionary *normalTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIColor blackColor],
                                            NSForegroundColorAttributeName,
                                            UIDEFAULTFONTSIZE(17),
                                            NSFontAttributeName,
                                            nil];
        [self.navigationBar setTitleTextAttributes:normalTextAttributes];
        self.navigationBar.barTintColor = UIColorFromRGB(0xF5F5F5);
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count == 1) {
        return NO;
    }
    return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
