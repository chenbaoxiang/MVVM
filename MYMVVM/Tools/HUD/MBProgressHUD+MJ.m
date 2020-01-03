//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"
#import "MBCustomView.h"
#import "MBProgressHUD.h"


@implementation MBProgressHUD (MJ)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.label.font = [UIFont systemFontOfSize:15.f];
    //设置文字 加载框颜色 样式
//    hud.contentColor = [UIColor hexColor:@"5e5e5e"];
    hud.contentColor = [UIColor whiteColor];
//    hud.bezelView.color = [UIColor hexColor:@"f6f6f6"];
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    // 设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]] imageWithColor:DefaultNavColor]];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(90.f, 90.f);
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1.5秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
}

//提示
+ (void)showPrompt:(NSString *)prompt {
    UIView * view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = prompt;
    hud.label.font = [UIFont systemFontOfSize:15.f];
    //设置文字 加载框颜色 样式
    hud.mode = MBProgressHUDModeText;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1.5秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

+ (void)showNoData:(NSString *)text toView:(UIView *)view {
    [self show:text icon:@"nodata.png" view:view];
}

+ (void)showWarning:(NSString *)text toView:(UIView *)view {
    [self show:text icon:@"warning.png" view:view];
}


#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    //设置文字 加载框颜色 样式
    hud.contentColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:15.f];
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.animationType = MBProgressHUDAnimationFade;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 代表蒙版效果
    hud.backgroundView.color = [UIColor clearColor];

    return hud;
}

+ (void)showNoData:(NSString *)text {
    [self showNoData:text toView:nil];
}

+ (void)showWarning:(NSString *)text {
    [self showWarning:text toView:nil];
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

@end
