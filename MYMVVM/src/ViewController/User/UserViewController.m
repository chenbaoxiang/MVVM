//
//  UserViewController.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "UserViewController.h"

#import "UserViewModel.h"
#import "UserTableViewCell.h"
@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UserViewModel *userViewModel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)UILabel *showLab;
@end

@implementation UserViewController

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
    self.userViewModel = [UserViewModel new];
    
    self.topImageView = [UIImageView new];
    self.topImageView.backgroundColor = kRandomColor;
    [self.view addSubview:self.topImageView];

    self.showLab = [UILabel new];
    [self.showLab append:@" " color:k153Color font:kFontSize(14)];
    self.showLab.backgroundColor = kRandomColor;
    self.showLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.showLab];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    self.tableView.delegate= self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:@"UserTableViewCell"];
    [self.view addSubview:self.tableView];
    
   
    
}
-(void)setupContraints{
    WEAKSELF;
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
        make.height.mas_equalTo(100);
      }];
    [self.showLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.topImageView.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.left.right.mas_equalTo(weakSelf.view);
       make.top.mas_equalTo(weakSelf.showLab.mas_bottom).offset(10);
    }];
   
    
}
-(void)addAction{
    
    
}
- (void)addBind {
    WEAKSELF;
    [RACObserve(self.userViewModel, dataSourceArr) subscribeNext:^(id x) {
        [weakSelf.topImageView sd_setImageWithURL:[NSURL URLWithString:x[0][@"showImage"]] placeholderImage:nil];
        [weakSelf.tableView reloadData];
    }];
    [RACObserve(self.userViewModel, labStr) subscribeNext:^(id x) {
        self.showLab.text = x;
    }];

}

-(void)requestData{
    WEAKSELF;
    [weakSelf showHUDAnimation];
   
    [self.userViewModel requestDataSuccess:^{
        [weakSelf stopHUDAnimation];
        [weakSelf.tableView reloadData];
    } faildBlock:^{
        [weakSelf stopHUDAnimation];
    }];
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.userViewModel.dataSourceArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 95;
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
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTableViewCell" forIndexPath:indexPath];
    UserModel *model = [UserModel mj_objectWithKeyValues:self.userViewModel.dataSourceArr[indexPath.row]];
    cell.userModel = model;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserModel *homeModeel = self.userViewModel.dataSourceArr[indexPath.row];
       
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
