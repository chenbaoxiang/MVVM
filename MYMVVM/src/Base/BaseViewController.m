//
//  BaseViewController.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/3.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame =CGRectMake(0,0, 45, 45);
    [leftBtn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    [leftBtn addActionHandler:^(NSInteger tag) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem  *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}

-(void)showHUDAnimation
{
    [MBProgressHUD showMessage:@"加载中" toView:self.view];
    [self performSelector:@selector(stopHUDAnimation) withObject:nil afterDelay:15];
}

-(void)stopHUDAnimation{
    [MBProgressHUD hideHUDForView:self.view];
}
@end
