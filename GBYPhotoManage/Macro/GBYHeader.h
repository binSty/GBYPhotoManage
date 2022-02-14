//
//  GBYHeader.h
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#ifndef GBYHeader_h
#define GBYHeader_h

#define kWindow [[[UIApplication sharedApplication] delegate] window]

#define WeakSelf __weak typeof(self) weakSelf = self;

/** frame适配布局相关*/
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kXX  [UIScreen mainScreen].bounds.size.width / 375.f
#define kYY  [UIScreen mainScreen].bounds.size.height / (kDevice_Is_iPhoneX ? 812.f : 667.f)

/** 线高适配*/
#define BY_LINE_WIDTH 1.0 / [UIScreen mainScreen].scale
#define Line_Default_Width (1*kYY)

/**字体大小及粗体和常规体*/
#define UIDEFAULTFONTSIZE(__VA_ARGS__)  ([UIFont fontWithName:@"PingFang-SC-Regular" size:BY_ScaleFont(__VA_ARGS__)])
#define UIMEDIUMTFONTSIZE(__VA_ARGS__)  ([UIFont fontWithName:@"PingFang-SC-Medium" size:BY_ScaleFont(__VA_ARGS__)])
/**字体比例*/
#define BY_ScaleFont(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375.f)*(__VA_ARGS__)

/*! 颜色大小定义*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFraomAlphaRGB(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

/** 机型视频 是否iPhone X以上*/
#define kDevice_Is_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//#define StatusBarHeight (kDevice_Is_iPhoneX ? [UIApplication sharedApplication].statusBarFrame.size.height : [UIApplication sharedApplication].keyWindow.safeAreaInsets.top)
#define StatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define BYStatuBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define NavigationBarHeight (kDevice_Is_iPhoneX ? 88.f : 64.f)
#define TabbarHeight        (kDevice_Is_iPhoneX ? 83.f : 49.f)
#define BYSafeBottomMagin  (kDevice_Is_iPhoneX ? 34.f : 0.f)

//NSLog
#ifdef DEBUG
#define BYLog(format, ...) printf("%s:(%d)  method: %s \n%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SLog(format, ...)
#endif

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif


#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#endif /* GBYHeader_h */
