//
//  MainTabBaseVC.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/3.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "MainTabBaseVC.h"

@interface MainTabBaseVC ()

@end

@implementation MainTabBaseVC
- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)showHUDAnimation
{
    [MBProgressHUD showMessage:@"加载中" toView:self.view];
    [self performSelector:@selector(stopHUDAnimation) withObject:nil afterDelay:15];
}

-(void)stopHUDAnimation{
    [MBProgressHUD hideHUDForView:self.view];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
