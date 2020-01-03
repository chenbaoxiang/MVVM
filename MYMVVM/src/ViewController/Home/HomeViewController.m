//
//  HomeViewController.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "HomeView.h"
#import "HomeTableViewCell.h"
@interface HomeViewController ()
@property(nonatomic,strong)HomeViewModel *homeViewModel;
@property(nonatomic,strong)HomeView *homeView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubviews];
    [self setupContraints];
    [self addAction];
    [self requestData];
}
-(void)setupSubviews{
    _homeViewModel = [HomeViewModel new];
    
    _homeView = [HomeView new];
    _homeView.tableView.dataSource = self.homeViewModel;
    _homeView.tableView.delegate = self.homeViewModel;
    [_homeView.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    [self.view addSubview:_homeView];
}
-(void)setupContraints{
    WEAKSELF;
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
        make.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideBottom);
    }];
    
}
-(void)addAction{
    
    
}
-(void)requestData{
    WEAKSELF;
    [weakSelf showHUDAnimation];
   
    [self.homeViewModel requestDataSuccess:^{
        [weakSelf stopHUDAnimation];
        [weakSelf.homeView.tableView reloadData];
    } faildBlock:^{
        [weakSelf stopHUDAnimation];
    }];
    
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
