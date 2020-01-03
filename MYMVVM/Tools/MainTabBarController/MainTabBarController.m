//
//  HomeTabViewController.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/3.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "UserViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate,UIApplicationDelegate>


@end

@implementation MainTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:13],NSFontAttributeName,nil] forState:UIControlStateNormal];

}
- (void)setupViewControllers {

    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.title = @"首页";
    UINavigationController *homeNav = [[UINavigationController alloc]
                                   initWithRootViewController:homeVC];
    homeNav.navigationBar.translucent = NO;
    homeNav.navigationBar.shadowImage = [[UIImage alloc] init];
    [homeNav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [homeNav.navigationBar setTintColor:[UIColor grayColor]];
    [homeNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [homeNav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UserViewController *userVC  = [[UserViewController alloc] init];
    UINavigationController *userNav = [[UINavigationController alloc]
                                 initWithRootViewController:userVC];
    userNav.navigationBar.translucent = NO;
    userNav.navigationBar.shadowImage = [[UIImage alloc] init];
    [userNav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [userNav.navigationBar setTintColor:[UIColor grayColor]];
    [userNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [userNav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self customizeTabBarForController:self];
    [self setViewControllers:@[homeNav,userNav]];
//    self.tabBar.backgroundColor = TabBarBgColor;
}

- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            
                            CYLTabBarItemTitle : [self getTitles][0],
                            CYLTabBarItemImage : @"tab_service",
                            CYLTabBarItemSelectedImage : @"tab_service_p",
                            };
    

    
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : [self getTitles][1],
                            CYLTabBarItemImage : @"tab_user",
                            CYLTabBarItemSelectedImage : @"tab_user_p",
                            };
    
    
    NSArray *tabBarItemsAttributes = @[ dict1, dict3];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
//    // 默认选中底标底标的方法
//    [tabBarController setViewDidLayoutSubViewsBlockInvokeOnce:YES block:^(CYLTabBarController *tabBarController) {
//          NSUInteger delaySeconds = 1;
//          dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
//          dispatch_after(when, dispatch_get_main_queue(), ^{
//               tabBarController.selectedIndex = 1;
//          });
//      }];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = kMainColor;
     
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [self setTintColor:kMainColor];
    
    self.delegate = self;
    
    

}






#pragma mark Getter

-(NSArray *)getTitles{
    NSArray * titles = @[@"首页",@"我的"];
    return titles;
}



#pragma mark net


@end
