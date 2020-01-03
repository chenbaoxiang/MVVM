//
//  NSString+Decimal.m
//  Client
//
//  Created by 马永州 on 2018/11/1.
//  Copyright © 2018年 loveRain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "NSString+Extend.h"

NSString *const WifiIdTypeNotFound = @"Not Found";
NSString *const WifiIdTypeSSID     = @"SSID";   //Wifi SSID
NSString *const WifiIdTypeBSSID    = @"BSSID";  //mac


@implementation NSString (Extend)

+(NSString *)macAddress
{
    return [NSString fetchIdWithType:WifiIdTypeBSSID];
}

+(NSString *)fetchIdWithType:(NSString *)wifiIdType
{
    NSString *idStr = WifiIdTypeNotFound;
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            idStr = [dict valueForKey:wifiIdType];
        }
    }
    return idStr;
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    //NSLog(@"Output = %@", returnStr);
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}


+ (NSString *)encodeXMLCharactersIn:(NSString *)source {
    if (![source isKindOfClass:[NSString class]] || !source)
        return @"";
    
    NSString *result = [NSString stringWithString:source];
    
    if ([result rangeOfString:@"&"].location != NSNotFound)
        result = [[result componentsSeparatedByString: @"&"] componentsJoinedByString: @"&amp;"];
    
    if ([result rangeOfString:@"<"].location != NSNotFound)
        result = [[result componentsSeparatedByString: @"<"] componentsJoinedByString: @"&lt;"];
    
    if ([result rangeOfString:@">"].location != NSNotFound)
        result = [[result componentsSeparatedByString: @">"] componentsJoinedByString: @"&gt;"];
    
    if ([result rangeOfString:@"\""].location != NSNotFound)
        result = [[result componentsSeparatedByString: @"\""] componentsJoinedByString: @"&quot;"];
    
    if ([result rangeOfString:@"'"].location != NSNotFound)
        result = [[result componentsSeparatedByString: @"'"] componentsJoinedByString: @"&apos;"];
    
    return result;
}

+ (NSString *) decodeXMLCharactersIn:(NSString *)source {
    if (![source isKindOfClass:[NSString class]] || !source)
        return @"";
    
    NSString *result = [NSString stringWithString:source];
    
    if ([result rangeOfString:@"&amp;"].location != NSNotFound)
        result = [[result componentsSeparatedByString: @"&amp;"] componentsJoinedByString: @"&"];
    
    if ([result rangeOfString:@"&lt;"].location != NSNotFound)
        result = [[result componentsSeparatedByString: @"&lt;"] componentsJoinedByString: @"<"];
    
    if ([result rangeOfString:@"&gt;"].location != NSNotFound)
        result = [[result componentsSeparatedByString: @"&gt;"] componentsJoinedByString: @">"];
    
    if ([result rangeOfString:@"&quot;"].location != NSNotFound)
        result = [[result componentsSeparatedByString: @"&quot;"] componentsJoinedByString: @"\""];
    
    if ([result rangeOfString:@"&apos;"].location != NSNotFound)
        result = [[result componentsSeparatedByString: @"&apos;"] componentsJoinedByString: @"'"];
    
    return result;
}

+(NSString *)stringWithdecimalDouble:(double)conversionValue
{
    NSString * doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
        NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

- (BOOL)isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)containStr:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

- (BOOL)isNumber {
    NSCharacterSet *cs;
    cs = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSRange specialrang = [self rangeOfCharacterFromSet:cs];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidPhone
{
    
//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9])|(16[0-9])|(19[0-9]))\\d{8}$";
    
    
    NSString *regex = @"^1[0-9]{10}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    if (!isMatch)
    {
        return NO;
    }
    return YES;
    
}

- (BOOL)isEmoji{
    BOOL returnValue = NO;
    
    const unichar hs = [self characterAtIndex:0];
    // surrogate pair
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3) {
            returnValue = YES;
        }
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }
    
    return returnValue;
}


-(BOOL)isValidRange:(NSRange)rangeCompare
{
    return rangeCompare.length <= self.length && rangeCompare.location < self.length;
}

- (NSString *)addStr:(NSString *)string {
    if (!string || string.length == 0) {
        return self;
    }
    return [self stringByAppendingString:string];
}
/**
 字符串替换
 
 @param replaceString 被替换的字符串
 @param string 要替换的字符串
 @return 替换后的字符串
 */

- (NSString *)replace:(NSString *)replaceString with:(NSString *)string
{
    NSString * avatarURL = [[[NSMutableString alloc] initWithString:self] stringByReplacingOccurrencesOfString:replaceString withString:string];
    return avatarURL;
}

-(NSString *)subStringFromString:(NSString *)sSplitter{
    NSRange rangeSplitter = [self rangeOfString:sSplitter];
    if ([self isValidRange:rangeSplitter]) {
        return [self substringFromIndex:rangeSplitter.length + rangeSplitter.location];
    }
    return nil;
}

- (NSString *)pinYinWithString:(NSString *)chinese
{
    NSString  * pinYinStr = [NSString string];
    if (chinese.length){
        NSMutableString * pinYin = [[NSMutableString alloc]initWithString:chinese];
        if(CFStringTransform((__bridge CFMutableStringRef)pinYin, 0, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"pinyin: %@", pinYin);
        }
        if (CFStringTransform((__bridge CFMutableStringRef)pinYin, 0, kCFStringTransformStripDiacritics, NO)) {
            NSLog(@"pinyin: %@", pinYin);
            pinYinStr = [pinYinStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
    }
    return pinYinStr;
}

+(NSString *)checkNil:(NSString *)str defaultStr:(NSString *)strDefault
{
    if (!str || str.length == 0){
        return strDefault;
    }
    return str;
}

#pragma mark - 散列函数
- (NSString *)md5String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha256String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - HMAC 散列函数
- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA512, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 文件散列函数

#define FileHashDefaultChunkSizeForReadingData 4096

- (NSString *)fileMD5Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_MD5_CTX hashCtx;
    CC_MD5_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_MD5_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)fileSHA1Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA1_CTX hashCtx;
    CC_SHA1_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA1_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)fileSHA256Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA256_CTX hashCtx;
    CC_SHA256_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA256_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)fileSHA512Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA512_CTX hashCtx;
    CC_SHA512_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA512_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 助手方法
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

- (int)numberCount
{
    
    //[self length];
    
    int count = 0;
    
    int len = (int) self.length;
    
    for (int i = 0; i<len; i++) {
        // 获取i位置对应的字符(char)
        char c = [self characterAtIndex:i];
        
        if (c>='0' && c<='9')
        {
            count++;
        }
    }
    return count;
}

- (NSString *)homeDir{
    NSString *dir = NSHomeDirectory();
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSString *)cacheDir {
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSString *)documentDir {
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSString *)tmpDir {
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (NSNumber *)numberValue
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    return [formatter numberFromString:self];
}

- (NSString *)removeZero
{
    NSNumber *nsNumber = [self numberValue];
    NSString *outNumber = [NSString stringWithFormat:@"%@",nsNumber];
    return outNumber;
}

#pragma mark 时间戳

-(NSDate *)dateFromTimestamp
{
    if([self longLongValue] > 140000000000) {
        return [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    }else{
        return [NSDate dateWithTimeIntervalSince1970:[self longLongValue]];
    }
}

-(NSString *)dateStrFromTimestamp:(NSString * )form
{
    NSDate * date = [self dateFromTimestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:form];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+(NSString *)timestampNow
{
    return [self timestampFromDate:[NSDate date]];
}

+(NSString *)timestampNowAddTimestamp:(NSInteger)timestamp
{
    NSDate * now = [NSDate date];
    NSDate * ojbDate = [now dateByAddingTimeInterval:timestamp];
    return [self timestampFromDate:ojbDate];
}

+(NSString *)timestampFromDate:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

+(NSString *)distaceTimestamp:(NSString *)timesTamp withTimestamp:(NSString *)timesTamp2
{
    long long time1 = [timesTamp longLongValue];
    long long time2 = [timesTamp2 longLongValue];
    
    if (time1 < time2){
        return [NSString stringWithFormat:@"%lld",time2 - time1];
    }else{
        return [NSString stringWithFormat:@"%lld",time1 - time2];
    }
}

+(NSDate *)dateString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}



-(NSString *)todayFormatter{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [NSDate date];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    NSDate * date = [self dateFromTimestamp];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return [self dateStrFromTimestamp:@"今天:HH:mm"];
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return [self dateStrFromTimestamp:@"昨天:HH:mm"];
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return [self dateStrFromTimestamp:@"明天:HH:mm"];
    }
    else
    {
        return [self dateStrFromTimestamp:@"YYYY-MM-dd HH:mm:ss"];
    }
}

-(NSString *)todayFormatter2
{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [NSDate localDate];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    NSDate * date = [NSDate localDate:[self dateFromTimestamp]];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return [self dateStrFromTimestamp:@"今天:HH:mm"];
    }
    else if ([dateString isEqualToString:yesterdayString])
    {
        return [self dateStrFromTimestamp:@"昨天:HH:mm"];
    }
    else if ([dateString isEqualToString:tomorrowString])
    {
        return [self dateStrFromTimestamp:@"明天:HH:mm"];
    }
    else
    {
        return [self dateStrFromTimestamp:@"MM月dd日 HH:mm"];
    }
}

@end;
