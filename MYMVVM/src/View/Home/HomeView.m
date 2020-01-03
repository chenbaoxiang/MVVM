//
//  HomeView.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "HomeView.h"
#import "HomeViewModel.h"
@interface HomeView ()
@property(nonatomic,strong)HomeViewModel *homeViewModel;
@end
@implementation HomeView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubviews];
        [self setupContraints];
        [self addAction];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setupSubviews{
    self.topImageView = [UIImageView new];
    self.topImageView.backgroundColor = kRandomColor;
    [self addSubview:self.topImageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    [self addSubview:self.tableView];
  
    
}
-(void)setupContraints{
    WEAKSELF;
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.left.right.mas_equalTo(weakSelf);
           make.height.mas_equalTo(100);
       }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.topImageView.mas_bottom).offset(10);
    }];
    
}
-(void)addAction{
   
    
}
@end
