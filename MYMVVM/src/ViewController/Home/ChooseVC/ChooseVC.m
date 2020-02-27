//
//  ChooseVC.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/2/27.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "ChooseVC.h"

@interface ChooseVC ()
@property(nonatomic,strong)UIButton *chooseTimeBtn;
@property(nonatomic,strong)UIButton *chooseCityBtn;
@end

@implementation ChooseVC

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
    
    self.chooseTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseTimeBtn.titleLabel.font = kFontSize(13);
    [self.chooseTimeBtn setTitle:@"选择时间" forState:UIControlStateNormal];
    [self.chooseTimeBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.view addSubview:self.chooseTimeBtn];
    
    self.chooseCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseCityBtn.titleLabel.font = kFontSize(13);
    [self.chooseCityBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    [self.chooseCityBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.view addSubview:self.chooseCityBtn];
    
}
-(void)setupContraints{
    WEAKSELF;
    [self.chooseTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(50);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [self.chooseCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.chooseTimeBtn.mas_bottom).offset(50);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
   
   
    
 
}
-(void)addAction{
    WEAKSELF;
    [self.chooseTimeBtn addActionHandler:^(NSInteger tag) {
        [MOFSPickerManager shareManger].datePicker.toolBar.cancelBar.textColor = [UIColor redColor];
               NSDateFormatter *df = [NSDateFormatter new];
               df.dateFormat = @"yyyy-MM-dd";
               NSDate *date = [df dateFromString:@"2015-6"];
               [MOFSPickerManager shareManger].datePicker.toolBar.titleBarTitle = @"选择日期";
               [MOFSPickerManager shareManger].datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
               [[MOFSPickerManager shareManger] showDatePickerWithTitle:@"" cancelTitle:@"取消" commitTitle:@"完成" firstDate:nil minDate:date maxDate:nil datePickerMode:UIDatePickerModeDate tag:0 commitBlock:^(NSDate *date) {
                   NSLog(@" ---> %@", [df stringFromDate:date]);
               } cancelBlock:^{

               }];
    }];
    [self.chooseCityBtn addActionHandler:^(NSInteger tag) {
        [MOFSPickerManager shareManger].addressPicker.usedXML = true;
               [[MOFSPickerManager shareManger] showMOFSAddressPickerWithTitle:@"选择地址" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString * _Nullable address, NSString * _Nullable zipcode) {
                    NSLog(@" ---> %@ ---> %@", address,zipcode);
               } cancelBlock:^{
                   
               }];
    }];
    
}
-(void)addBind{
    
    
}
-(void)requestData{
  
    
}
@end
