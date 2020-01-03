//
//  NSDate+Extend.h
//  Client
//
//  Created by loveRain on 2019/1/18.
//  Copyright © 2019年 loveRain. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate(Extend)

/**
 今天0点  UTC

 @return date
 */
+ (NSDate *)zeroOfDate;

/**
 获取传入时间的本地时间

 @param date 时间
 @return 转换后的本地时间
 */
+ (NSDate *)localDate:(NSDate *)date;

/**
 本地时间

 @return 本地时间
 */
+ (NSDate *)localDate;
@end

NS_ASSUME_NONNULL_END
