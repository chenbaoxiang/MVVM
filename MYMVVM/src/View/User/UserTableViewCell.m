//
//  UserTableViewCell.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/6.
//  Copyright © 2020 陈宝祥. All rights reserved.
//


#import "UserTableViewCell.h"
@interface UserTableViewCell()
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *orderNumLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *stateLab;
@end
@implementation UserTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
        [self setupContraints];
    }
    return self;
}


-(void)setupSubviews{
    
    self.backView = [UIView new];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.shadowOffset = CGSizeMake(1, 1);
    self.backView.layer.shadowColor = kShadowColor;
    self.backView.layer.shadowOpacity = 1;
    self.backView.layer.shadowRadius = 2;
    self.backView.layer.cornerRadius = 5;
    [self addSubview:self.backView];
    
    self.topView = [UIView new];
    self.topView.backgroundColor = kMainColor;
    [Manager setPartRoundWithView:self.topView rect:CGRectMake(0, 0, kScreenWidth-30, 30) corners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadius:5];
    [self.backView addSubview:self.topView];
    
    self.timeLab = [UILabel new];
    [self.timeLab append:@"2019" color:[UIColor whiteColor] font:kFontSize(12)];
    self.timeLab.textAlignment = NSTextAlignmentRight;
    [self.topView addSubview:self.timeLab];
    
    self.orderNumLab = [UILabel new];
    [self.orderNumLab append:@"单号 :" color:[UIColor whiteColor] font:kFontSize(12)];
    self.orderNumLab.textAlignment = NSTextAlignmentLeft;
    [self.topView addSubview:self.orderNumLab];
    
    self.leftImageView = [UIImageView new];
    self.leftImageView.layer.cornerRadius = 3;
    self.leftImageView.backgroundColor = kMainColor;
    [self.backView addSubview:self.leftImageView];
    
    self.titleLab = [UILabel new];
    [self.titleLab append:@"维修标题" color:k102Color font:[UIFont systemFontOfSize:13]];
    [self addSubview:self.titleLab];
    
//    self.stateLab = [UILabel new];
//    [self.stateLab append:@"处理中" color:RGB(249, 147, 38) font:kFontSize(10)];
//    self.stateLab.backgroundColor = RGBA(249, 147, 38, 0.1);
//    self.stateLab.layer.masksToBounds = YES;
//    self.stateLab.layer.cornerRadius = 10;
//    self.stateLab.textAlignment = NSTextAlignmentCenter;
//    [self.backView addSubview:self.stateLab];
   
}

-(void)setupContraints{
    WEAKSELF;
 
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf);
        make.width.mas_equalTo(kScreenWidth-30);
        make.height.mas_equalTo(75);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.backView);
        make.height.mas_equalTo(30);
    }];
    [self.orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(weakSelf.topView);
        make.width.mas_equalTo(kScreenWidth/2-10);
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(weakSelf.topView);
        make.width.mas_equalTo(kScreenWidth/2-10);
    }];
//    [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(20);
//        make.centerY.mas_equalTo(weakSelf.backView.mas_bottom).offset(-25);
//    }];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.height.mas_equalTo(30);
        make.centerY.mas_equalTo(weakSelf.backView.mas_bottom).offset(-25);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftImageView.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(weakSelf.leftImageView.mas_centerY);
    }];
   
}

-(void)setUserModel:(UserModel *)userModel{
    _userModel = userModel;
    self.titleLab.text = userModel.name;
    self.timeLab.text = userModel.time;
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:userModel.headerImage] placeholderImage:nil];
}

@end

