//
//  GBYPickerLimitedViewController.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/11.
//

#import "GBYPickerLimitedViewController.h"
#import <Photos/Photos.h>
#import "GBYHomePhotoCollectionViewCell.h"

static NSString *const collectionCellID = @"collectionTopCellID";

@interface GBYPickerLimitedViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PHPhotoLibraryChangeObserver>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) NSMutableArray *muDataArray;

@end

@implementation GBYPickerLimitedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    [self _setDataInit];
    [self _setUIInit];
}

- (void)_setDataInit {
    [self getLiaPhotoImage];
}

- (void)getLiaPhotoImage {
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    // ascending 为YES时，按照照片的创建时间升序排列;为NO时，则降序排列
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    // PHFetchResult这个类型可以当成NSArray使用。此时所有可获取照片都已拿到，可以刷新UI进行显示
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:option];
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    // 遍历每一个PHAsse对象
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAsset *asset = (PHAsset *)obj;
        NSLog(@"照片名%@", [asset valueForKey:@"filename"]);
        [assets addObject:asset];
    }];
    self.muDataArray = [[NSMutableArray alloc] init];
    NSArray *arr = @[@""];
    /// 空白一个占位数据
    self.muDataArray = [NSMutableArray arrayWithArray:arr];
    NSMutableArray *phpotDataArray = [[NSMutableArray alloc] init];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    for (PHAsset *set in assets) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            [[PHImageManager defaultManager] requestImageForAsset:set targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
                //设置处理图片
                [phpotDataArray addObject:result];
                dispatch_group_leave(group);
            }];
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, phpotDataArray.count)];
        [self.muDataArray insertObjects:phpotDataArray atIndexes:indexes];
        [self.mainCollectionView reloadData];
    });
}

- (void)_setUIInit {
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 30);
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
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

#pragma mark - PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.muDataArray removeAllObjects];
        [self getLiaPhotoImage];
    });
}

- (void)backButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
        NSLog(@"占位图点击");
    } else {
        UIImage *image = self.muDataArray[indexPath.row];
        /// 回调选择的图片，可以自定义勾选按钮，多选统一回调数据
        NSLog(@"%@", image);
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

- (void)dealloc {
    NSLog(@"dealloc");
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

@end
