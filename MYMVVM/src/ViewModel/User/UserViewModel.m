//
//  UserViewModel.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "UserViewModel.h"

@implementation UserViewModel
-(void)requestDataSuccess:(void (^)(void))successBlock faildBlock:(void (^)(void))faildBlock{
    [CBXNetworking getWithUrl:CombStr(HOST_URL, kGetAdvertisement) refreshCache:YES success:^(NSURLSessionDataTask *task, id response) {
        NSDictionary *dic = [Manager locationDataWithSourceName:@"StaticData"];
        self.dataSourceArr = [dic tm_arrayForKey:@"Infos"];
        if ([[dic tm_stringForKey:@"labShows"]isEqualToString:@"1"]) {
            self.labStr = @"1";
        }else{
            self.labStr = @"不是";
        }
        if (successBlock) {
            successBlock();
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (faildBlock) {
            faildBlock();
        }
    }];
}

@end
