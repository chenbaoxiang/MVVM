//
//  UserViewController.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()
@property(nonatomic,strong)UIView*topView;
@end

@implementation UserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubviews];
    [self setupContraints];
    [self addAction];
}
-(void)setupSubviews{
    self.topView = [UIView new];
    self.topView.backgroundColor = kRandomColor;
    [self.view addSubview:self.topView];
    
}
-(void)setupContraints{
    WEAKSELF;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideBottom).offset(-10);
    }];
    
}
-(void)addAction{
    
}

@end
