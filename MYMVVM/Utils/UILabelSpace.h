//
//  UILabelSpace.h
//  freeLife
//
//  Created by 陈宝祥 on 2019/10/30.
//  Copyright © 2019 陈宝祥. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface UILabel(YFAdd)
/**
  修改label内容距 `top` `left` `bottom` `right` 边距
 */
@property (nonatomic, assign) UIEdgeInsets yf_contentInsets;
@end
