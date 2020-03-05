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
@property(nonatomic,strong)UILabel *daylab;
@property(nonatomic,strong)dispatch_source_t timer;
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
    self.daylab = [UILabel new];
    [self.daylab append:@"2020-05-05" color:[UIColor whiteColor] font:kFontSize(14)];
    self.daylab.backgroundColor = kMainColor;
    [self.view addSubview:self.daylab];
    
}
-(void)setupContraints{
    WEAKSELF;
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop).offset(50);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [self.daylab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.sendCodeBtn.mas_bottom).offset(50);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(200);
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
[self activeCountDownAction];
    
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
#pragma mark - 倒计时计数

- (void)activeCountDownAction {
    
    // 1.计算截止时间与当前时间差值
    // 倒计时的时间 测试数据
    NSString *deadlineStr = @"2020-08-19 12:00:00";
    // 当前时间的时间戳
    NSString *nowStr = [self getCurrentTimeyyyymmdd];
    // 计算时间差值
    NSInteger secondsCountDown = [self getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];
    
    // 2.使用GCD来实现倒计时 用GCD这个写有一个好处，跳页不会清零 跳页清零会出现倒计时错误的
    WEAKSELF;
    
    if (_timer == nil) {
        __block NSInteger timeout = secondsCountDown; // 倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(weakSelf.timer);
                    weakSelf.timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.daylab.text = @"当前活动已结束";
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"活动倒计时 %02ld : %02ld : %02ld", hours, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days == 0) {
                            weakSelf.daylab.text = strTime;
                        } else {
                            weakSelf.daylab.text = [NSString stringWithFormat:@" %ld天 %02ld : %02ld : %02ld", days, hours, minute, second];
                        }
                        
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(weakSelf.timer);
        }
    }
}

/**
 *  获取当天的字符串
 *
 *  @return 格式为年-月-日 时分秒
 */
- (NSString *)getCurrentTimeyyyymmdd {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
}

/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    
    NSInteger timeDifference = 0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    
    return timeDifference;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
