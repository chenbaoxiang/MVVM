//
//  AlertToolViewController.m
//  ELife
//
//  Created by 陈宝祥 on 2019/12/5.
//  Copyright © 2019 陈宝祥. All rights reserved.
//

#import "AlertToolViewController.h"

@interface AlertToolViewController ()

@end

@implementation AlertToolViewController

//重写方法
+ (instancetype)initWBAlerControllerWithTitle:(NSString *)title message:(NSString *)message style:(NSString *)style titleArr:(NSMutableArray *)titleArr alerAction:(void (^)(NSInteger index))alerAction{
    //参数说明:
    //title表示弹框的标题;
    //message表示弹框的展示的信息;
    //style是0或者1;代表弹框的类型;UIAlertControllerStyleActionSheet = 0,UIAlertControllerStyleAlert = 1;
    //titleArr为弹框中出现的按钮标题的数组;个数你自己决定;
    //alerAction为block回调事件,因为这里只需要判断点击的按钮坐标就可以,其他需要壳自行添加参数;
    
    //判断弹框类型
    if ([style isEqualToString:@"1"]) {
        AlertToolViewController *alert = [AlertToolViewController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:k102Color range:NSMakeRange(0,message.length )];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, message.length)];
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        for (NSInteger i = 0; i < titleArr.count; i++) {
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                if (alerAction) {
                    alerAction(i);
                    
                }
                
            }];
            [confirm setValue:i == 0 ? k102Color: kMainColor forKey:@"titleTextColor"];
            [alert addAction:confirm];
        }
        return alert;
        
    }else{
        AlertToolViewController *alert = [AlertToolViewController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSInteger i = 0; i < titleArr.count; i++) {
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if (alerAction) {
                    alerAction(i);
                }
                
            }];
            [alert addAction:confirm];
        }
        
        return alert;
    }
    
}

-(void)showWBAler{
    [[self getCurrentVC] presentViewController:self animated:YES completion:nil];
}


/**
 得到当前控制视图

 @return 当前控制视图
 */
-(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
