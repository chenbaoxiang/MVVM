//
//  UILabel.h
//  Client
//
//  Created by 马永州 on 2018/11/20.
//  Copyright © 2018年 loveRain. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel(Extend)

/**
 设置单颜色 attr

 @param text 内容
 @param color 颜色
 @param range 区间
 */
-(void)setText:(NSString *)text rangeColor:(UIColor *)color range:(NSRange)range;

-(void)setTimestamp:(NSInteger)timestamp withTimerStop:(void (^)(void))handle;
-(void)setLabelSpaceText:(NSString *)text  color:(UIColor *)color withSpace:(CGFloat)space withFont:(UIFont*)font;

-(void)append:(NSString *)text color:(UIColor *)color;
-(void)append:(NSString *)text color:(UIColor *)color font:(UIFont *)font;
-(void)appendImage:(NSString *)image size:(CGSize)size;

-(CGSize)returnLabelSize:(NSString *)content boundingRectWithSize:(CGSize)size fontSize:(CGFloat)fontSize;
@end

NS_ASSUME_NONNULL_END
