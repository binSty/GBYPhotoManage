//
//  GBYPHPickerViewController.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/10.
//

#import "GBYPHPickerViewController.h"
#import "GBYHomePhotoCollectionViewCell.h"
#import "GBYPhotoTipView.h"
#import <PhotosUI/PhotosUI.h>
#import "GBYPickerLimitedViewController.h"
#import "GBYNavigationController.h"

static NSString *const collectionCellID = @"collectionTopCellID";

@interface GBYPHPickerViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PHPickerViewControllerDelegate>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) NSMutableArray *muDataArray;

@property (nonatomic, strong) NSMutableArray *phpotDataArray;

@property (nonatomic, strong) GBYPhotoTipView *bottomButtonView;

@property (nonatomic, strong) PHPickerConfiguration *configuration;

@end

@implementation GBYPHPickerViewController

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
            } else {
                NSLog(@"未允许相机");
            }
        }];
    } else if (num == 1) {
        [[GBYSystemPermissionsManage sharedInstance] getPhotoPermissions:^(NSString * _Nonnull photoPer) {
            if ([photoPer isEqualToString:@"limited"]) {
                [self limitedPhotoManage];
            } else if ([photoPer isEqualToString:@"1"]) {
                [self _phCameraManage];
            } else {
                NSLog(@"未允许相册");
            }
        }];
    }
}

#pragma mark -- PHPickerViewController
#pragma mark --
- (void)_phCameraManage {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 初始化配置项
        PHPickerConfiguration *configuration = [[PHPickerConfiguration alloc] init];
        configuration.selectionLimit = 0;  // 设置最大选择上线，默认为1(即单选)，0表示跟随系统允许的上限

        // 设置多媒体类型，默认为 imagesFilter
        PHPickerFilter *imagesFilter = [PHPickerFilter imagesFilter];
    //    PHPickerFilter *videosFilter = [PHPickerFilter videosFilter];
    //    PHPickerFilter *livePhotosFilter = [PHPickerFilter livePhotosFilter];
        configuration.filter = [PHPickerFilter anyFilterMatchingSubfilters:@[imagesFilter]];

        // 使用配置初始化照片选择控制器
        PHPickerViewController *pickerCro = [[PHPickerViewController alloc] initWithConfiguration:configuration];
        pickerCro.delegate = self;  // 设置代理

        [self presentViewController:pickerCro animated:YES completion:nil];
    });
}

- (void)limitedPhotoManage {
    dispatch_async(dispatch_get_main_queue(), ^{
        GBYPickerLimitedViewController *limitedVC = [[GBYPickerLimitedViewController alloc] init];
        GBYNavigationController *nav = [[GBYNavigationController alloc] initWithRootViewController:limitedVC];
        [self presentViewController:nav animated:YES completion:nil];
    });
}

- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results API_AVAILABLE(ios(14)) {
    self.phpotDataArray = [[NSMutableArray alloc] init];
    [self.view showLoadingView];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    for (PHPickerResult *result in results) {
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
                if ([object isKindOfClass:[UIImage class]]) {
                    UIImage *originalImage = (UIImage*)object;
                    [self.phpotDataArray addObject:originalImage];
                    dispatch_group_leave(group);
                }
            }];
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.view hideLoadingView];
        NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.phpotDataArray.count)];
        [self.muDataArray insertObjects:self.phpotDataArray atIndexes:indexes];
        [self.mainCollectionView reloadData];
    });
    [picker dismissViewControllerAnimated:YES completion:nil];
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
