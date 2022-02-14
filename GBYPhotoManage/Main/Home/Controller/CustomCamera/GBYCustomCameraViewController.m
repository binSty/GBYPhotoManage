//
//  GBYCustomCameraViewController.m
//  GBYPhotoManage
//
//  Created by YD_Dev_BinY on 2022/2/11.
//

#import "GBYCustomCameraViewController.h"
#import "GBYCameraPickerController.h"

@interface GBYCustomCameraViewController ()

@end

@implementation GBYCustomCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInit];
}


- (void)setInit {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 300, kScreenW - 60, 40)];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"点击调用相机" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *)sender {
    if ([GBYCameraPickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        GBYCameraPickerController *cameraVC = [[GBYCameraPickerController alloc] initWithParam];
        [self presentViewController:cameraVC animated:YES completion:nil];
    } else {
        NSLog(@"相机不可用");
    }
}

@end
