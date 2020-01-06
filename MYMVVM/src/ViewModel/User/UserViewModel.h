//
//  UserViewModel.h
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserViewModel : NSObject
@property (nonatomic, strong) NSArray *dataSourceArr;
@property (nonatomic, strong) NSString *labStr;
// 请求数据
- (void)requestDataSuccess:(void(^)(void))successBlock faildBlock:(void(^)(void))faildBlock;
@end

NS_ASSUME_NONNULL_END
