//
//  HomeTableViewCell.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/3.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "HomeTableViewCell.h"
@interface HomeTableViewCell()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *lineLab;
@end
@implementation HomeTableViewCell

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

    
    self.titleLab = [UILabel new];
    [self.titleLab append:@" " color:k102Color font:[UIFont systemFontOfSize:13]];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLab];
    
    self.lineLab = [UILabel new];
    self.lineLab.backgroundColor = kLineColor;
    [self addSubview:self.lineLab];
   
}

-(void)setupContraints{
    WEAKSELF;
 

    [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(0);
    }];

    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(weakSelf).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        make.left.right.mas_equalTo(weakSelf.lineLab);
        make.top.mas_equalTo(weakSelf.mas_top);
        make.bottom.mas_equalTo(weakSelf.lineLab.mas_top);
    }];
   
}

-(void)setHomeModel:(HomeModel *)homeModel{
    _homeModel = homeModel;
    self.titleLab.text = homeModel.name;
  
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLab.text = titleStr;
}
@end

