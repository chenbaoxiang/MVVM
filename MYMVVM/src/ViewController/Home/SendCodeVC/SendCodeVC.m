//
//  SendCodeVC.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/6.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "SendCodeVC.h"

@interface SendCodeVC ()
@property(nonatomic,strong)UIButton *sendCodeBtn;
@end

@implementation SendCodeVC

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
    
    self.sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendCodeBtn.titleLabel.font = kFontSize(13);
    [self.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.sendCodeBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.view addSubview:self.sendCodeBtn];
    
}
-(void)setupContraints{
    WEAKSELF;
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(50);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
   
   
    
 
}
-(void)addAction{
    WEAKSELF;
    [self.sendCodeBtn addActionHandler:^(NSInteger tag) {
        [Manager sendCodeShowBtn:weakSelf.sendCodeBtn];
    }];
    
}
-(void)addBind{
    
    
}
-(void)requestData{
  
    
}
-(void)sendCodeShow{
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置按钮的样式
                [self.sendCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.sendCodeBtn setTitleColor:kMainColor forState:UIControlStateNormal];
                self.sendCodeBtn.userInteractionEnabled = YES;
            });

        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置按钮显示读秒效果
                [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%d秒 重新发送", seconds] forState:UIControlStateNormal];
                [self.sendCodeBtn setTitleColor:k153Color forState:UIControlStateNormal];
                self.sendCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
@end
