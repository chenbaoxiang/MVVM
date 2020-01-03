//
//  CBXSegmented.m
//  ELife
//
//  Created by 陈宝祥 on 2019/11/27.
//  Copyright © 2019 陈宝祥. All rights reserved.
//

#import "CBXSegmented.h"

typedef void(^ClickSegmentBlock)(NSString *segmentSign);
@interface CBXSegmented ()
@property(nonatomic,copy)ClickSegmentBlock clickSegmentBlock;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIView *midBackView;
@property(nonatomic,strong)UIView *rollView;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;

@end

@implementation CBXSegmented

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
        [self setupContraints];
        [self addAction];
    }
    return self;
}

-(void)setupSubviews{
    self.backView = [UIView new];
    [self addSubview:self.backView];
    
    self.midBackView = [UIView new];
    self.midBackView.backgroundColor =RGB(236, 236, 236);
    self.midBackView.layer.cornerRadius = 15;
    [self addSubview:self.midBackView];
    // 滚动条
    self.rollView = [UIView new];
    self.rollView.backgroundColor = kMainColor;
    self.rollView.layer.cornerRadius = 15;
    [self.midBackView addSubview:self.rollView];
    //
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setTitle:self.leftStr forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.midBackView addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitle:self.rightStr forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:k102Color forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.midBackView addSubview:self.rightBtn];
    
    

}
-(void)setupContraints{
    WEAKSELF;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self.midBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.backView);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(30);
    }];
    [self.rollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.midBackView.mas_left);
        make.centerY.height.mas_equalTo(weakSelf.midBackView);
        make.width.mas_equalTo(110);
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(weakSelf.midBackView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.midBackView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    

}
-(void)addAction{
    WEAKSELF;
    [self.leftBtn addActionHandler:^(NSInteger tag) {
        weakSelf.clickSegmentBlock(@"left");
        [weakSelf signUpAndLoginAnimation:@"left"];
    }];
    [self.rightBtn addActionHandler:^(NSInteger tag) {
         weakSelf.clickSegmentBlock(@"right");
        [weakSelf signUpAndLoginAnimation:@"right"];
    }];
}
-(void)fatchSegmentBtn:(void (^)(NSString * _Nonnull))handler{
    self.clickSegmentBlock = handler;
}

-(void)setLeftStr:(NSString *)leftStr{
    [self.leftBtn setTitle:leftStr forState:UIControlStateNormal];
}
-(void)setRightStr:(NSString *)rightStr{
     [self.rightBtn setTitle:rightStr forState:UIControlStateNormal];
}
#pragma mark -- view从左滑到右
-(void)signUpAndLoginAnimation:(NSString *)Sign {
    if (self.rollView.frame.origin.x == 0 && [@"right" isEqualToString:Sign] ) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.leftBtn setTitleColor:k102Color forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        });
        
        [UIView animateWithDuration:0.5f
        animations:^{
           
            [self.rollView setFrame:CGRectMake(self.rollView.frame.origin.x+110, self.rollView.frame.origin.y, self.rollView.frame.size.width , self.rollView.frame.size.height)];
        }];
    }else if (self.rollView.frame.origin.x == 110 && [@"left" isEqualToString:Sign]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:k102Color forState:UIControlStateNormal];
        });
        [UIView animateWithDuration:0.5f
        animations:^{
            [self.rollView setFrame:CGRectMake(self.rollView.frame.origin.x-110, self.rollView.frame.origin.y, self.rollView.frame.size.width , self.rollView.frame.size.height)];
           
        }];
    }
    
}
@end
