//
//  CBXSegmented.h
//  ELife
//
//  Created by 陈宝祥 on 2019/11/27.
//  Copyright © 2019 陈宝祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBXSegmented : UIView
@property(nonatomic,strong)NSString *leftStr;
@property(nonatomic,strong)NSString *rightStr;
-(void)fatchSegmentBtn:(void(^)(NSString *segmentSign))handler;
@end

NS_ASSUME_NONNULL_END
