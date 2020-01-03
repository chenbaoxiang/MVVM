//
//  HomeViewModel.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeTableViewCell.h"
@interface HomeViewModel()

@end
@implementation HomeViewModel

-(void)requestDataSuccess:(void (^)(void))successBlock faildBlock:(void (^)(void))faildBlock{
    [CBXNetworking getWithUrl:CombStr(HOST_URL, kGetAdvertisement) refreshCache:YES success:^(NSURLSessionDataTask *task, id response) {
        NSDictionary *dic = [Manager locationDataWithSourceName:@"StaticData"];
        self.dataSourceArr = [dic tm_arrayForKey:@"Infos"];
        if (successBlock) {
            successBlock();
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (faildBlock) {
            faildBlock();
        }
    }];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return self.dataSourceArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 75;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
    HomeModel *model = [HomeModel mj_objectWithKeyValues:self.dataSourceArr[indexPath.row]];
    cell.homeModel = model;
    return cell;
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
       if (self.callBlock) {
           HomeModel *homeModeel = self.dataSourceArr[indexPath.row];
           self.callBlock(homeModeel);
       }  
}

@end
