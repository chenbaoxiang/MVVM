//
//  ShowImageVC.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/6.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "ShowImageVC.h"
#import "HomeViewModel.h"
#import "LGPhoto.h"
@interface ShowImageVC ()<LGPhotoPickerBrowserViewControllerDataSource,LGPhotoPickerBrowserViewControllerDelegate>
@property(nonatomic,strong)HomeViewModel *homeViewModel;
@property(nonatomic,strong)UIImageView *showImageView;
@property (nonatomic, strong)NSMutableArray *LGPhotoPickerBrowserPhotoArray;
@property (nonatomic, strong)NSMutableArray *LGPhotoPickerBrowserURLArray;
@property (nonatomic, assign) LGShowImageType showType;
@property (nonatomic)NSUInteger selectIndex;
@end

@implementation ShowImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    [self setupContraints];
    [self addAction];
    [self addBind];
    [self requestData];
}

-(void)setupSubviews{
    self.view.backgroundColor = k241Color;
    self.homeViewModel = [HomeViewModel new];
    
    self.showImageView = [UIImageView new];
    self.showImageView.backgroundColor = [UIColor yellowColor];
    self.showImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.showImageView];
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    [self.showImageView addGestureRecognizer:singleTapGestureRecognizer];
   
    
}
-(void)setupContraints{
    WEAKSELF;
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
          make.left.right.mas_equalTo(weakSelf.view);
          make.height.mas_equalTo(185);
      }];
    
 
}
-(void)addAction{
    
}
-(void)addBind{
    [RACObserve(self.homeViewModel, showImageStr) subscribeNext:^(id x) {
        NSLog(@"x---x %@",x);
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:nil];
    }];
    
}
-(void)requestData{
    [self.homeViewModel requestSDCSuccess:^{
        
    } faildBlock:^{
        
    }];
    
}
- (void)singleTap:(UIGestureRecognizer*)gestureRecognizer{
    self.LGPhotoPickerBrowserURLArray = [NSMutableArray new];
    self.selectIndex = 0;
    LGPhotoPickerBrowserPhoto *photo = [[LGPhotoPickerBrowserPhoto alloc] init];
    photo.photoURL = [NSURL URLWithString:self.homeViewModel.showImageStr];
    [self.LGPhotoPickerBrowserURLArray addObject:photo];
     [self pushPhotoBroswerWithStyle:LGShowImageTypeImageURL];
    /*
    // 多张放大
        self.LGPhotoPickerBrowserURLArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < tempArr.count; i++) {
            LGPhotoPickerBrowserPhoto *photo = [[LGPhotoPickerBrowserPhoto alloc] init];
            photo.photoURL = [NSURL URLWithString:tempArr[i]];
            [self.LGPhotoPickerBrowserURLArray addObject:photo];
        }
     */

}

/**
 *  初始化图片浏览器
 */
- (void)pushPhotoBroswerWithStyle:(LGShowImageType)style{
    
    LGPhotoPickerBrowserViewController *BroswerVC = [[LGPhotoPickerBrowserViewController alloc] init];
    BroswerVC.delegate = self;
    BroswerVC.dataSource = self;
    BroswerVC.showType = style;
    self.showType = style;
    BroswerVC.currentPage =  (unsigned long)self.selectIndex ; //当前个数
    BroswerVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:BroswerVC animated:YES completion:nil];
    

//
    
}

#pragma mark - LGPhotoPickerBrowserViewControllerDataSource

- (NSInteger)photoBrowser:(LGPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{if (self.showType == LGShowImageTypeImageBroswer) {
        return self.LGPhotoPickerBrowserPhotoArray.count;
    } else if (self.showType == LGShowImageTypeImageURL) {
        return self.LGPhotoPickerBrowserURLArray.count;
    } else {
        NSLog(@"非法数据源");
        return 0;
    }
}

- (id<LGPhotoPickerBrowserPhoto>)photoBrowser:(LGPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    if (self.showType == LGShowImageTypeImageBroswer) {
        return [self.LGPhotoPickerBrowserPhotoArray objectAtIndex:indexPath.item];
    } else if (self.showType == LGShowImageTypeImageURL) {
        return [self.LGPhotoPickerBrowserURLArray objectAtIndex:indexPath.item];
    } else {
        NSLog(@"非法数据源");
        return nil;
    }
}
@end
