//
//  HomeViewModel.h
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataSourceArr;
// 点击cell回调
@property (nonatomic, strong) void(^callBlock)(HomeModel *homeModel);


// 请求数据
- (void)requestDataSuccess:(void(^)(void))successBlock faildBlock:(void(^)(void))faildBlock;
@end

NS_ASSUME_NONNULL_END
