//
//  ShadowVC.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/6.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "ShadowVC.h"

@interface ShadowVC ()
@property(nonatomic,strong)UIView *view1;   // 四圆角阴影
@property(nonatomic,strong)UIView *view2;   // 左上右上
@end

@implementation ShadowVC

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
    
    self.view1 = [UIView new];
    self.view1.backgroundColor = [UIColor whiteColor];
    [Manager shadowView:self.view1 color: RGBA(153, 153, 153, 0.3)];
    [self.view addSubview:self.view1];
    
    self.view2 = [UIView new];
    self.view2.backgroundColor = kMainColor;
    [Manager setPartRoundWithView:self.view2 rect:CGRectMake(0, 0, kScreenWidth-30, 30) corners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadius:10];
    [self.view1 addSubview:self.view2];
   
    
}
-(void)setupContraints{
    WEAKSELF;
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(50);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(100);
    }];
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(weakSelf.view1);
        make.height.mas_equalTo(30);
    }];
   
   
    
 
}
-(void)addAction{
    
}
-(void)addBind{
    
    
}
-(void)requestData{
  
    
}

@end
