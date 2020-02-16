//
//  HomeViewController.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "HomeTableViewCell.h"
#import "SDCScrollviewVC.h"     // 轮播图
#import "LGPhotoVC.h"           // 选择照片
#import "ShowImageVC.h"         // 点击图片放大
#import "ShadowVC.h"            // 圆角阴影
#import "SendCodeVC.h"          // 验证码倒计时
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)HomeViewModel *homeViewModel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)UILabel *showLab;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubviews];
    [self setupContraints];
    [self addAction];
    [self addBind];
    [self requestData];
}
-(void)setupSubviews{
    self.navigationItem.title = @"列表";
    _homeViewModel = [HomeViewModel new];
  
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    self.tableView.delegate= self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    [self.view addSubview:self.tableView];
    
   
    
}
-(void)setupContraints{
    WEAKSELF;

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.mas_equalTo(weakSelf.view);
       make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideBottom);
    }];
   
    
}
-(void)addAction{
    
    
}
- (void)addBind {
    WEAKSELF;
    [RACObserve(_homeViewModel, dataSourceArr) subscribeNext:^(id x) {
        [weakSelf.tableView reloadData];
    }];
   

}

-(void)requestData{
    WEAKSELF;
    [weakSelf showHUDAnimation];
   
    [self.homeViewModel requestDataSuccess:^{
        [weakSelf stopHUDAnimation];
        [weakSelf.tableView reloadData];
    } faildBlock:^{
        [weakSelf stopHUDAnimation];
    }];
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.homeViewModel.dataSourceArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
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
//    HomeModel *model = [HomeModel mj_objectWithKeyValues:self.homeViewModel.dataSourceArr[indexPath.row]];
//    cell.homeModel = model;
    cell.titleStr = self.homeViewModel.dataSourceArr[indexPath.row];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title =  self.homeViewModel.dataSourceArr[indexPath.row];
    
    if ([@"轮播图" isEqualToString:title]) {
        SDCScrollviewVC *VC = [SDCScrollviewVC new];
        VC.navigationItem.title = @"轮播图";
        [self.navigationController pushViewController:VC animated:YES];
    }else if ([@"图片放大" isEqualToString:title]){
        ShowImageVC *VC = [ShowImageVC new];
        VC.navigationItem.title = @"图片放大";
        [self.navigationController pushViewController:VC animated:YES];
    }else if ([@"相机相册" isEqualToString:title]){
        LGPhotoVC *VC = [LGPhotoVC new];
        VC.navigationItem.title = @"相机相册";
        [self.navigationController pushViewController:VC animated:YES];
    }else if ([@"圆角阴影" isEqualToString:title]){
        ShadowVC *VC = [ShadowVC new];
        VC.navigationItem.title = @"圆角阴影";
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if ([@"验证码倒计时" isEqualToString:title]){
        SendCodeVC *VC = [SendCodeVC new];
        VC.navigationItem.title = @"验证码倒计时";
        [self.navigationController pushViewController:VC animated:YES];
    }
    
        
    
       
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
