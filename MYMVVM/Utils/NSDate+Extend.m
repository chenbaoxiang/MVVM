//
//  NSDate+Extend.m
//  Client
//
//  Created by loveRain on 2019/1/18.
//  Copyright © 2019年 loveRain. All rights reserved.
//

#import "NSDate+Extend.h"

@implementation NSDate(Extend)

+ (NSDate *)zeroOfDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    
    // components.nanosecond = 0 not available in iOS
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:ts];
//    NSTimeZone *zone = [NSTimeZone localTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return date;
}

+ (NSDate *)localDate:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];             // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date];    // 以秒为单位返回当前时间与系统格林尼治时间的差
    NSDate *dateNow = [date dateByAddingTimeInterval:time];     // 然后把差的时间加
    return dateNow;
}

+(NSDate *)localDate
{
    NSDate *date = [NSDate date]; // 获得时间对象
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加
    return dateNow;
}
@end
