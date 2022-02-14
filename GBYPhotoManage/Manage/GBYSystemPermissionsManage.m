//
//  GBYSystemPermissionsManage.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/10.
//

#import "GBYSystemPermissionsManage.h"
#import <Photos/Photos.h>

@implementation GBYSystemPermissionsManage

+ (instancetype)sharedInstance {
    static GBYSystemPermissionsManage *permissionsObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        permissionsObj = [[GBYSystemPermissionsManage alloc] init];
    });
    return permissionsObj;
}

- (void)getPhotoPermissions:(void (^)(NSString * _Nonnull))completion {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    //首次安装APP，用户还未授权 系统会请求用户授权
    if (@available(iOS 14.0, *)) {
        status = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelReadWrite];
        // iOS14 新增的选择部分照片权限时
        // 首次状态之后，部分照片权限走这里
        if (status == PHAuthorizationStatusNotDetermined) {
            [self setPhotoPermissions:completion];
        } else if (status == PHAuthorizationStatusLimited) {
            if (completion) {
                completion(@"limited");
            }
        } else if (status == PHAuthorizationStatusAuthorized) {
            if (completion) {
                completion(@"1");
            }
        } else {
            if (completion) {
                completion(@"0");
            }
        }
    } else {
        if (status == PHAuthorizationStatusNotDetermined) {
            [self setPhotoPermissions:completion];
        } else if (status == PHAuthorizationStatusAuthorized) {
            if (completion) {
                completion(@"1");
            }
        } else {
            if (completion) {
                completion(@"0");
            }
        }
    }
}

- (void)setPhotoPermissions:(void (^)(NSString * _Nonnull))completion {
    if (@available(iOS 14.0, *)) {
        [PHPhotoLibrary requestAuthorizationForAccessLevel:PHAccessLevelReadWrite handler:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusLimited) {
                if (completion) {
                    completion(@"limited");
                }
            } else if (status == PHAuthorizationStatusAuthorized) {
                if (completion) {
                    completion(@"1");
                }
            } else {
                if (completion) {
                    completion(@"0");
                }
            }
        }];
    }else {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                if (completion) {
                    completion(@"1");
                }
            } else {
                if (completion) {
                    completion(@"0");
                }
            }
        }];
    }
}

- (void)getCameraPermissions:(void (^)(BOOL))completion {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (completion) {
                        completion(YES);
                    }
                } else {
                    if (completion) {
                        completion(NO);
                    }
                }
            });
        }];
    } else if (status == AVAuthorizationStatusAuthorized) {
        if (completion) {
            completion(YES);
        }
    } else {
        if (completion) {
            completion(NO);
        }
    }
}

@end
