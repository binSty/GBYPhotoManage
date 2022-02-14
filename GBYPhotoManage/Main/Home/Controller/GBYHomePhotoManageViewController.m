//
//  GBYHomePhotoManageViewController.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/10.
//

#import "GBYHomePhotoManageViewController.h"
#import "GBYHomePhotoCollectionViewCell.h"
#import "GBYPhotoTipView.h"
#import "GBYPickerLimitedViewController.h"
#import "GBYNavigationController.h"

static NSString *const collectionCellID = @"collectionTopCellID";

@interface GBYHomePhotoManageViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) NSMutableArray *muDataArray;

@property (nonatomic, strong) NSMutableArray *phpotDataArray;

@property (nonatomic, strong) GBYPhotoTipView *bottomButtonView;

@end

@implementation GBYHomePhotoManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self _setDataInit];
    [self _setUIInit];
}

- (void)_setDataInit {
    self.muDataArray = [[NSMutableArray alloc] init];
    NSArray *arr = @[@""];
    /// 空白一个占位数据
    self.muDataArray = [NSMutableArray arrayWithArray:arr];
}

- (void)_setUIInit {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, kScreenW, kScreenH - NavigationBarHeight - BYSafeBottomMagin) collectionViewLayout:flowLayout];
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.showsHorizontalScrollIndicator = NO;
    self.mainCollectionView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.mainCollectionView registerClass:[GBYHomePhotoCollectionViewCell class] forCellWithReuseIdentifier:collectionCellID];
    [self.view addSubview:self.mainCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.muDataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GBYHomePhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    if (indexPath.row == self.muDataArray.count - 1) {
        cell.cellPhotoImageView.image = [UIImage imageNamed:@"photoBackImg"];
    } else {
        cell.cellPhotoImageView.image = self.muDataArray[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.muDataArray.count - 1) {
        [self.bottomButtonView showSheetView];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenW - 30*kXX - 30*kXX) / 4, (kScreenW - 30*kXX - 30*kXX) / 4);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10*kYY, 15*kXX, 10*kYY, 15*kXX);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10*kXX;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10*kYY;
}

- (void)actionMethod:(NSInteger)num {
    if (num == 0) {
        [[GBYSystemPermissionsManage sharedInstance] getCameraPermissions:^(BOOL showPermissions) {
            if (showPermissions) {
                /// UIImagePickerController
                [self _cameraManage];
            } else {
                NSLog(@"未允许相机");
            }
        }];
    } else if (num == 1) {
        
        [[GBYSystemPermissionsManage sharedInstance] getPhotoPermissions:^(NSString * _Nonnull photoPer) {
            if ([photoPer isEqualToString:@"limited"]) {
                [self limitedPhotoManage];
            } else if ([photoPer isEqualToString:@"1"]) {
                [self _photoManage];
            } else {
                NSLog(@"未允许相册");
            }
        }];
    }
}


#pragma mark -- UIImagePickerController
#pragma mark --
- (void)_cameraManage {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
        // 设置拍照类型
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置可用的媒体类型、默认只包含public.image，如果想选择视频，请添加public.movie
        imagePickerVC.mediaTypes = @[@"public.image"];
        imagePickerVC.delegate = self;
        // 是否允许编辑
//        imagePickerVC.allowsEditing = YES;
        // 视频最大拍摄时间
//        imagePickerVC.videoMaximumDuration = 20;
        // 拍摄视频质量（如果质量选取的质量过高，会自动降低质量）
//        imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        // 相机媒体类型
//        imagePickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 使用前置还是后置摄像头
//        imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 是否开闪光灯
//        imagePickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
}

- (void)_photoManage {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerVC.mediaTypes = @[@"public.image"];
            imagePickerVC.delegate = self;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        });
    }
}

- (void)limitedPhotoManage {
    dispatch_async(dispatch_get_main_queue(), ^{
        GBYPickerLimitedViewController *limitedVC = [[GBYPickerLimitedViewController alloc] init];
        GBYNavigationController *nav = [[GBYNavigationController alloc] initWithRootViewController:limitedVC];
        [self presentViewController:nav animated:YES completion:nil];
    });
}

/// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.phpotDataArray = [[NSMutableArray alloc] init];
    if (self.isEditing) {
        //获得编辑后的图片
        UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
        [self.phpotDataArray addObject:editedImage];
        NSMutableIndexSet  *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.phpotDataArray.count)];
        [self.muDataArray insertObjects:self.phpotDataArray atIndexes:indexes];
    } else {
        //获取照片的原图
        UIImage *originalImage = (UIImage *)info[UIImagePickerControllerOriginalImage];
        [self.phpotDataArray addObject:originalImage];
        NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.phpotDataArray.count)];
        [self.muDataArray insertObjects:self.phpotDataArray atIndexes:indexes];
    }
    [self.mainCollectionView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark --
#pragma mark -- lazy init
- (GBYPhotoTipView *)bottomButtonView {
    if (!_bottomButtonView) {
        _bottomButtonView = [[GBYPhotoTipView alloc] initWithFrame:self.view.bounds];
        WeakSelf;
        _bottomButtonView.actionBlock = ^(NSInteger indexNum) {
            [weakSelf actionMethod:indexNum];
        };
    }
    return _bottomButtonView;
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
