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

@interface HomeViewModel : NSObject
@property (nonatomic, strong) NSArray *dataSourceArr;
@property(nonatomic,strong)NSMutableArray *sdcArrey;
@property(nonatomic,strong)NSString *showImageStr;

// 首页列表数据
- (void)requestDataSuccess:(void(^)(void))successBlock faildBlock:(void(^)(void))faildBlock;
// 轮播图
- (void)requestSDCSuccess:(void(^)(void))successBlock faildBlock:(void(^)(void))faildBlock;
@end

NS_ASSUME_NONNULL_END
