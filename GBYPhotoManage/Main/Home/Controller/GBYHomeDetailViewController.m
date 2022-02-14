//
//  GBYHomeDetailViewController.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#import "GBYHomeDetailViewController.h"
#import "GBYHomePhotoManageViewController.h"
#import "GBYPHPickerViewController.h"

#import "GBYHomeDetailHeaderView.h"
#import "GBYHomeDetailTableViewCell.h"
#import "GBYHomeDetailModel.h"

static NSString *const cellID = @"cellID";

@interface GBYHomeDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *homeTableView;

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, strong) NSMutableArray *sectionDataArray;

@end

@implementation GBYHomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情页";
    self.sectionDataArray = [[NSMutableArray alloc] init];
    [self setDataInit];
    [self setControlInit];
}

- (void)setDataInit {
    NSArray *array = @[@{@"sectionTitle":@"系统API功能实现"}, @{@"sectionTitle":@"系统API功能PHImagePicker实现"}, @{@"sectionTitle":@"TZImagePickerController功能实现"}];
    for (NSDictionary *dict in array) {
        GBYHomeDetailModel *sectionModel = [GBYHomeDetailModel mj_objectWithKeyValues:dict];
        sectionModel.isCellOpen = YES;
        [self.sectionDataArray addObject:sectionModel];
    }
    self.dataArray = @[@"-- 点击跳转 --"];
}

- (void)setControlInit {
    
    [self.view addSubview:self.homeTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GBYHomeDetailModel *sectionItem = self.sectionDataArray[section];
    return sectionItem.isCellOpen ? self.dataArray.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40*kYY;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40*kYY;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    GBYHomeDetailModel *sectionTabModel = self.sectionDataArray[section];
    NSString *const headViewID = @"headViewID";
    GBYHomeDetailHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headViewID];
    if (!headView) {
        headView = [[GBYHomeDetailHeaderView alloc] initWithReuseIdentifier:headViewID];
    }
    headView.tintColor = [UIColor whiteColor];
    headView.sectionModel = sectionTabModel;
    __weak typeof(self) weakSelf = self;
    headView.headerTapClickBlock = ^{
        NSIndexSet *reloadSet = [NSIndexSet indexSetWithIndex:section];
        [weakSelf.homeTableView reloadSections:reloadSet withRowAnimation:UITableViewRowAnimationFade];
    };
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GBYHomeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GBYHomeDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.cellTextLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GBYHomePhotoManageViewController *manageVC = [[GBYHomePhotoManageViewController alloc] init];
        [self.navigationController pushViewController:manageVC animated:YES];
    } else if (indexPath.section == 1) {
        GBYPHPickerViewController *manageVC = [[GBYPHPickerViewController alloc] init];
        [self.navigationController pushViewController:manageVC animated:YES];
    }
}

#pragma mark -- lazy init
- (UITableView *)homeTableView {
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, kScreenW, kScreenH - NavigationBarHeight) style:UITableViewStylePlain];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _homeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 15.0, *)) {
            _homeTableView.sectionHeaderTopPadding = 0;
        }
    }
    return _homeTableView;
}

@end
