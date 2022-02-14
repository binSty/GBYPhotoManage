//
//  GBYHomeViewController.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/9.
//

#import "GBYHomeViewController.h"
#import "GBYCustomCameraViewController.h"
#import "GBYHomeDetailViewController.h"

static NSString *const cellID = @"cellID";

@interface GBYHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *homeTableView;

@property (nonatomic, copy) NSArray *dataArray;

@end


@implementation GBYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    [self setDataInit];
    [self setControlInit];
}

- (void)setDataInit {
    self.dataArray = @[@"相机相册功能测试", @"自定义相机实现"];
}

- (void)setControlInit {
    
    [self.view addSubview:self.homeTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40*kYY;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GBYHomeDetailViewController *detailVC = [[GBYHomeDetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        GBYCustomCameraViewController *detailVC = [[GBYCustomCameraViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
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
    }
    return _homeTableView;
}


@end
