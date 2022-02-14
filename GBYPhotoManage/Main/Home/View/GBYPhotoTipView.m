//
//  GBYPhotoTipView.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/10.
//

#import "GBYPhotoTipView.h"
#import "GBYPhotoTipTableViewCell.h"

static NSString *const cellID = @"BYBottomSheetTableViewCellID";

@interface GBYPhotoTipView () <UITableViewDelegate, UITableViewDataSource>

/** 容器视图*/
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UITableView *bottomTabView;

@property (nonatomic, copy) NSArray *tabDataArray;

@end

@implementation GBYPhotoTipView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setInit];
    }
    return self;
}

- (void)setInit {
    
    self.tabDataArray = @[@"相机", @"相册", @"取消"];
    CGFloat heightTab = self.tabDataArray.count * 50*kYY + 10*kYY;
    self.bottomTabView.frame = CGRectMake(0, kScreenH - heightTab - BYSafeBottomMagin, kScreenW, heightTab);
}

- (void)showSheetView {
    [kWindow addSubview:self];
    [self addSubview:self.containerView];
    [self addSubview:self.bottomTabView];
    // 动画前初始位置
    CGRect rect = self.bottomTabView.frame;
    rect.origin.y = self.bounds.size.height;
    self.bottomTabView.frame = rect;
    self.containerView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.alpha = 0.2;
        CGFloat alertViewHeight = self.bottomTabView.bounds.size.height;
        CGRect rect = self.bottomTabView.frame;
        rect.origin.y -= alertViewHeight;
        self.bottomTabView.frame = rect;
    }];
}

- (void)hideSheetView {
    [UIView animateWithDuration:0.2 animations:^{
        CGFloat alertViewHeight = self.bottomTabView.bounds.size.height;
        CGRect rect = self.bottomTabView.frame;
        rect.origin.y += alertViewHeight;
        self.bottomTabView.frame = rect;
        self.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)didTapMaskView:(UITapGestureRecognizer *)tapGes {
    [self hideSheetView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tabDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50*kYY;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GBYPhotoTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GBYPhotoTipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.cellTitleLb.text = self.tabDataArray[indexPath.row];
    if (indexPath.row == self.tabDataArray.count - 2) {
        cell.separatorLineView.hidden = NO;
    } else {
        cell.separatorLineView.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.actionBlock) {
        self.actionBlock(indexPath.row);
    }
    [self hideSheetView];
}

#pragma mark --
#pragma mark -- lazy init
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2f];
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapMaskView:)];
        [_containerView addGestureRecognizer:myTap];
    }
    return _containerView;
}

- (UITableView *)bottomTabView {
    if (!_bottomTabView) {
        _bottomTabView = [[UITableView alloc] init];
        _bottomTabView.backgroundColor = [UIColor whiteColor];
        _bottomTabView.delegate = self;
        _bottomTabView.dataSource = self;
        _bottomTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _bottomTabView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _bottomTabView;
}

@end
