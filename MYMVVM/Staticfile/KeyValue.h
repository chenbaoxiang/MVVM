//
//  KeyValue.h
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/3.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#ifndef KeyValue_h
#define KeyValue_h

//------------------------   size   ------------------------------
#define kScreenHeight                       [UIScreen mainScreen].bounds.size.height
#define kScreenWidth                        [UIScreen mainScreen].bounds.size.width

#define adaptValue                          [UIScreen mainScreen].bounds.size.width / 414
#define adaptFont(R)                        (R)*(kScreenWidth)/320.0

#define kUserDefaults  [NSUserDefaults standardUserDefaults]
#define kNSNotificationCenter  [NSNotificationCenter defaultCenter]

//------------------------   tool - color -----------------------------
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBA(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define     kRandomColor            [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]

#define kMainColor RGBA(14, 203, 110, 1)
#define kMainColorLayer RGBA(14, 203, 110, 0.1)
#define k102Color RGBA(102, 102, 102, 1)
#define k51Color RGBA(51, 51, 51, 1)
#define k153Color RGBA(153, 153, 153, 1)
#define k247Color RGBA(247, 247, 247, 1)
#define kShadowColor RGBA(153, 153, 153, 0.3).CGColor
#define CombStr(str1,str2)           [str1 stringByAppendingString:str2]
#define kFontSize(size) [UIFont systemFontOfSize:(size)]
#define kFontBoldSize(size)                   [UIFont boldSystemFontOfSize:(size)]
//------------------------   size   ------------------------------

#define kTopBarHeight 64


//------------------------   device   ------------------------------
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)


//------------------------   key  -----------------------------
#define kBuglyAppID @"0c607ce22a"
#define kWechatAppID @"wx41b7c1c1bcbf4af5"
#define kWechatAppSecret @"73e2f208572396c3a321eaee70b21c3c"

// 值
#define not_loginSuccess                    @"loginSuccess"
#define not_advertiseArr                    @"advertiseArr"
#define not_upDate                          @"upDate"  // 更新接口返回
#define not_tokenLose                       @"tokenLose"  // 更新接口返回
//存储
#define key_loginState                      @"loginState"
#define key_token                           @"token"


#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define Tel(s) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",s]]];

#define kWindow [UIApplication sharedApplication].windows[0]
#define WEAKSELF __weak typeof(self) weakSelf = self;

#endif /* KeyValue_h */
