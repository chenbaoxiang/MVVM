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
// 手机型号
+(NSString*)judgeIphoneType;
// 获取本地数据
+(NSDictionary *)locationDataWithSourceName:(NSString *)sourceName;
//  呼吸灯
+(CABasicAnimation *) AlphaLight:(float)time;
// 切圆角
+(void)setPartRoundWithView:(UIView *)view rect:(CGRect)rect corners:(UIRectCorner)corners cornerRadius:(float)cornerRadius ;  
// json串转json
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;
// 将时间戳转换成时间
+(NSString *)getTimeFromTimestamp:(double)time;
// 计算html字符串高度
+(CGFloat)returnHtmlHeight:(NSString*)str font:(UIFont*)font;
// 判断手机号正则
+(BOOL)isPhoneNum:(NSString*)phoneStr;

@end

NS_ASSUME_NONNULL_END
