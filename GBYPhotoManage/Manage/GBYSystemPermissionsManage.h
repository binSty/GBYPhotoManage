//
//  GBYSystemPermissionsManage.h
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GBYSystemPermissionsManage : NSObject

+ (instancetype)sharedInstance;

/**
 相机权限判断
 Privacy - Camera Usage Description
 */
- (void)getCameraPermissions:(void (^)(BOOL))completion;

/**
 相册权限判断
 Privacy - Photo Library Additions Usage Description
 Privacy - Photo Library Usage Description
 */
- (void)getPhotoPermissions:(void (^)(NSString *photoPer))completion;

@end

NS_ASSUME_NONNULL_END
