//
//  Manager.h
//  freeLife
//
//  Created by 陈宝祥 on 2019/10/18.
//  Copyright © 2019 陈宝祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject
+ (Manager *)shareManager;
#pragma mark --- 手机型号
+(NSString*)judgeIphoneType;
#pragma mark --- 获取本地数据
+(NSDictionary *)locationDataWithSourceName:(NSString *)sourceName;
#pragma mark --- 呼吸灯
+(CABasicAnimation *) AlphaLight:(float)time;
#pragma mark --- 切圆角
+(void)setPartRoundWithView:(UIView *)view rect:(CGRect)rect corners:(UIRectCorner)corners cornerRadius:(float)cornerRadius ;  
#pragma mark --- json格式字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;
#pragma mark --- 将时间戳转换成时间
+(NSString *)getTimeFromTimestamp:(double)time;
#pragma mark --- 计算html字符串高度
+(CGFloat)returnHtmlHeight:(NSString*)str font:(UIFont*)font;
#pragma mark --- 判断手机号正则
+(BOOL)isPhoneNum:(NSString*)phoneStr;
#pragma mark --- 字符串每三位加逗号(显示钱)
+(NSString *)hanleNums:(NSString *)numbers;
#pragma mark --- 获取当前网络
+(NSString *)getNetWorkStates;
#pragma mark --- 字典转json串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
#pragma mark --- 生成uuid
+ (NSString *)uuidString;
#pragma mark 去除字符串中前后空格
+(NSString *)removeSpaceAndNewline:(NSString *)str;
#pragma mark 验证邮箱合理性
+(BOOL)checkEmail:(NSString *)email;
#pragma mark 获取当前时间
+(NSDateComponents *)GetCurrentDate;
#pragma mark --- 设置阴影
+(void)shadowView:(UIView*)view color:(UIColor *)color;
#pragma mark --- 获取验证码
+(void)sendCodeShowBtn:(UIButton *)btn;
@end

NS_ASSUME_NONNULL_END
