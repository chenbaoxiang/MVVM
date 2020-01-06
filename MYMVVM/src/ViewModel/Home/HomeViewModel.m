//
//  HomeViewModel.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "HomeViewModel.h"

@interface HomeViewModel()

@end
@implementation HomeViewModel

-(void)requestDataSuccess:(void (^)(void))successBlock faildBlock:(void (^)(void))faildBlock{
    [CBXNetworking getWithUrl:CombStr(HOST_URL, kGetAdvertisement) refreshCache:YES success:^(NSURLSessionDataTask *task, id response) {
        NSDictionary *dic = [Manager locationDataWithSourceName:@"StaticData"];
        self.dataSourceArr = [dic tm_arrayForKey:@"functionList"];
       
        if (successBlock) {
            successBlock();
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (faildBlock) {
            faildBlock();
        }
    }];
}
-(void)requestSDCSuccess:(void (^)(void))successBlock faildBlock:(void (^)(void))faildBlock{
    self.sdcArrey = [NSMutableArray new];
        NSDictionary *dic = [Manager locationDataWithSourceName:@"StaticData"];
        NSArray *arr = [dic tm_arrayForKey:@"Infos"];
    self.showImageStr = arr[0][@"headerImage"];
    for (NSDictionary *dic in arr) {
        [self.sdcArrey addObject:dic[@"headerImage"]];
    }
    
    if (successBlock) {
        successBlock();
    }

}


@end
