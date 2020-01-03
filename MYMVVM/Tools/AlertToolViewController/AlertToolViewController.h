//
//  AlertToolViewController.h
//  ELife
//
//  Created by 陈宝祥 on 2019/12/5.
//  Copyright © 2019 陈宝祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertToolViewController : UIAlertController

+ (instancetype)initWBAlerControllerWithTitle:(NSString *)title message:(NSString *)message style:(NSString *)style titleArr:(NSMutableArray *)titleArr alerAction:(void (^)(NSInteger index))alerAction;

-(void)showWBAler;
@end

NS_ASSUME_NONNULL_END
