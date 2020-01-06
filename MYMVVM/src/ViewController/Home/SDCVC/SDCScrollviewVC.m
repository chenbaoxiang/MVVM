//
//  SDCScrollviewVC.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/6.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "SDCScrollviewVC.h"
#import "HomeViewModel.h"
#import "SDCycleScrollView.h"           // 轮播图
@interface SDCScrollviewVC ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)HomeViewModel *homeViewModel;
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView ;// 轮播图
@end

@implementation SDCScrollviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    [self setupContraints];
    [self addAction];
    [self addBind];
    [self requestData];
}

-(void)setupSubviews{
    self.view.backgroundColor = k241Color;
    self.homeViewModel = [HomeViewModel new];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 40, kScreenWidth, 185) delegate:self placeholderImage:nil];
    [self.view addSubview:self.cycleScrollView];
   
    
}
-(void)setupContraints{
    WEAKSELF;
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(185);
    }];
}
-(void)addAction{
    
}
-(void)addBind{
    
    
}
-(void)requestData{
    [self.homeViewModel requestSDCSuccess:^{
         NSLog(@"%@",self.homeViewModel.sdcArrey);
        self.cycleScrollView.imageURLStringsGroup = self.homeViewModel.sdcArrey;
    } faildBlock:^{
        
    }];
    
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%@",self.homeViewModel.sdcArrey[index]);
}
@end
