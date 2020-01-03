//
//  NSString+Decimal.h
//  Client
//
//  Created by 马永州 on 2018/11/1.
//  Copyright © 2018年 loveRain. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const WifiIdTypeNotFound;
UIKIT_EXTERN NSString *const WifiIdTypeSSID;
UIKIT_EXTERN NSString *const WifiIdTypeBSSID;

@interface NSString (Extend)
#pragma mark - device 函数

/**
 return mac address when wifi

 @return mac address
 */
+(NSString * )macAddress;
/**
 iOS 获取Wifi的SSID及MAC地址

 @param wifiIdType wifiIDType
 @return string
 */
+(NSString *)fetchIdWithType:(NSString *)wifiIdType;

#pragma mark - 编码函数

/**
 
 unicode如何转换成中文

 @param unicodeStr unicode
 @return 中文
 */
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

/**
 编码xml 特殊字符

 @param source 要编码的xml字符串
 @return 编码后的xml字符串
 */
+(NSString *)encodeXMLCharactersIn:(NSString *)source;

/**
 解码xml 特殊字符

 @param source 要解码的xml字符串
 @return 解码后的xml字符串
 */
+(NSString *)decodeXMLCharactersIn:(NSString *)source;

/**
 double 转字符串

 @param conversionValue double 数值
 @return 转换后的字符串
 */
+(NSString *)stringWithdecimalDouble:(double)conversionValue;
/**
 字符串组合
 
 @param string another string
 @return 组合字符串
 */
- (NSString *)addStr:(NSString *)string;
/**
 字符串替换

 @param replaceString 被替换的字符串
 @param string 要替换的字符串
 @return 替换后的字符串
 */
- (NSString *)replace:(NSString *)replaceString with:(NSString *)string;
/**
 得到指定字符串后面的字符串

 @param sSplitter 字符串
 @return 截断后的字符串
 */
- (NSString *)subStringFromString:(NSString *)sSplitter;

/**
 汉字转拼音
 
 @param chinese 汉字
 @return 转换后的字符串
 */
- (NSString *)pinYinWithString:(NSString *)chinese;
#pragma mark - 判断函数

+(NSString *)checkNil:(NSString *)str defaultStr:(NSString *)strDefault;
/**
 判断字符串是否包含子字符串

 @param subString 子字符串
 @return 是否
 */
- (BOOL)containStr:(NSString *)subString;

/**
 判读是不是有效的邮箱
 
 @return 是否
 */
- (BOOL)isValidEmail;

/**
 判读是不是有效的手机号
 @return 是否
 */
- (BOOL)isValidPhone;

/**
 判读是不是Emoji表情

@return 是否
*/
- (BOOL)isEmoji;

/**
 判读是不是数字

 @return 是否
 */
- (BOOL)isNumber;


/**
 是否是有效的区间

 @param r 区间
 @return 是否
 */
-(BOOL)isValidRange:(NSRange)r;

#pragma mark - 散列函数
/**
 *  计算MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  <p>提示：随着 MD5 碰撞生成器的出现，MD5 算法不应被用于任何软件完整性检查或代码签名的用途。<p>
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)md5String;

/**
 *  计算SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)sha1String;

/**
 *  计算SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)sha256String;

/**
 *  计算SHA 512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512
 *  @endcode
 *
 *  @return 128个字符的SHA 512散列字符串
 */
- (NSString *)sha512String;

#pragma mark - HMAC 散列函数
/**
 *  计算HMAC MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl dgst -md5 -hmac "key"
 *  @endcode
 *
 *  @return 32个字符的HMAC MD5散列字符串
 */
- (NSString *)hmacMD5StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1 -hmac "key"
 *  @endcode
 *
 *  @return 40个字符的HMAC SHA1散列字符串
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256 -hmac "key"
 *  @endcode
 *
 *  @return 64个字符的HMAC SHA256散列字符串
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512 -hmac "key"
 *  @endcode
 *
 *  @return 128个字符的HMAC SHA512散列字符串
 */
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

#pragma mark - 文件散列函数

/**
 *  计算文件的MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 file.dat
 *  @endcode
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)fileMD5Hash;

/**
 *  计算文件的SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha1 file.dat
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)fileSHA1Hash;

/**
 *  计算文件的SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha256 file.dat
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)fileSHA256Hash;

/**
 *  计算文件的SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha512 file.dat
 *  @endcode
 *
 *  @return 128个字符的SHA512散列字符串
 */
- (NSString *)fileSHA512Hash;

#pragma mark 尺寸计算函数
/**
 计算高度

 @param font 字体
 @param maxW 最大宽度
 @return 指定宽的尺寸
 */
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/**
 计算宽度

 @param font 字体
 @return 计算的尺寸
 */
-(CGSize)sizeWithFont:(UIFont *)font;


/**
 计算字符串中阿拉伯数字的个数

 @return 个数
 */
- (int) numberCount;

/**
 

 @return number
 */
- (NSNumber *)numberValue;

/**
 去除float小数点后无效0

 @return 有效字符串
 */
- (NSString *)removeZero;

#pragma mark path 路径函数

/**
 *  返回Home的完整路径名
 */
- (NSString *)homeDir;
/**
 *  返回缓存路径的完整路径名
 */
- (NSString *)cacheDir;
/**
 *  返回文档路径的完整路径名
 */
- (NSString *)documentDir;
/**
 *  返回临时路径的完整路径名
 */
- (NSString *)tmpDir;
#pragma mark 时间戳
+(NSString *)timestampNow;
+(NSString *)timestampNowAddTimestamp:(NSInteger)timestamp;
+(NSString *)timestampFromDate:(NSDate *)date;

+(NSString *)distaceTimestamp:(NSString *)timesTamp withTimestamp:(NSString *)timesTamp2;

+(NSDate *)dateString:(NSString *)dateStr;

-(NSDate *)dateFromTimestamp;
-(NSString *)dateStrFromTimestamp:(NSString * )form;
-(NSString *)todayFormatter;
-(NSString *)todayFormatter2;
@end

