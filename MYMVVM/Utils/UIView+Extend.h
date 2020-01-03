//
//  UIView+Extend.h
//  Client
//
//  Created by 马永州 on 2018/11/13.
//  Copyright © 2018年 loveRain. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(Extend)


-(UIView *)creatTopLine:(CGFloat)height
               withLeft:(CGFloat)left
              withRight:(CGFloat)right
              withColor:(UIColor *)color;

-(UIView *)creatBottomLine:(CGFloat)height
                  withLeft:(CGFloat)left
                 withRight:(CGFloat)right
                 withColor:(UIColor *)color;

-(UIView *)creatLeftLine:(CGFloat)width
                 withTop:(CGFloat)top
              withBottom:(CGFloat)bottom
               withColor:(UIColor *)color;

-(UIView *)creatRightLine:(CGFloat)width withRight:(CGFloat)right
                  withTop:(CGFloat)top
               withBottom:(CGFloat)bottom
                withColor:(UIColor *)color;

-(UIView *)creatCircleBorderView:(CGFloat)width
                       withColor:(UIColor *)color;

/*设置顶部圆角*/
- (void)setCornerOnTop:(CGFloat )cornerRadius;
/*设置底部圆角*/
- (void)setCornerOnBottom:(CGFloat )cornerRadius;
/*设置左边圆角*/
- (void)setCornerOnLeft:(CGFloat )cornerRadius;
/*设置右边圆角*/
- (void)setCornerOnRight:(CGFloat )cornerRadius;
/*设置四边圆角*/
- (void)setAllCorner:(CGFloat )cornerRadius;
@end

NS_ASSUME_NONNULL_END
