//
//  LGPhotoVC.m
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/6.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import "LGPhotoVC.h"
#import "LGPhoto.h" // 相册选图片
@interface LGPhotoVC ()<LGPhotoPickerViewControllerDelegate>
@property(nonatomic,strong)UIImageView *showImageView;
@property(nonatomic,strong)UIButton *chooseBtn;
@property(nonatomic,strong)NSMutableArray *imageArr;
@end

@implementation LGPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = k241Color;
    self.imageArr = [NSMutableArray new];
    [self setupSubviews];
    [self setupContraints];
    [self addAction];
    [self addBind];
    [self requestData];
}
-(void)setupSubviews{
    self.showImageView = [UIImageView new];
    self.showImageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.showImageView];
    
    self.chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseBtn setTitle:@"选取" forState:UIControlStateNormal];
    [self.chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.chooseBtn.titleLabel.font = kFontSize(14);
    self.chooseBtn.backgroundColor = kMainColor;
    self.chooseBtn.layer.masksToBounds = YES;
    self.chooseBtn.layer.cornerRadius = 30;
    
    [self.view addSubview:self.chooseBtn];
}
-(void)setupContraints{
    WEAKSELF;
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(190);
    }];
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.showImageView.mas_bottom).offset(30);
        make.width.height.mas_equalTo(60);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
    }];
  
}
-(void)addAction{
    WEAKSELF;
    [self.chooseBtn addActionHandler:^(NSInteger tag) {
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"拍照",@"从相册选取",@"取消", nil];
        AlertToolViewController *alert =[AlertToolViewController initWBAlerControllerWithTitle:nil message:nil style:@"2" titleArr:arr  alerAction:^(NSInteger index) {
            //这里为点击事件的回调;
            if (index == 0) {
                NSLog(@"1");
                [weakSelf presentCameraSingle];
            }
            if (index == 1) {
                NSLog(@"2");
                [weakSelf presentPhotoPickerViewControllerWithStyle:LGShowImageTypeImagePicker];
               
            }
            if (index == 3) {
                NSLog(@"2");
               
            }
        }];
        [alert showWBAler];
    }];
}
-(void)addBind{
    
    
}
-(void)requestData{
   
    
}
/**
 *  初始化相册选择器
 */
- (void)presentPhotoPickerViewControllerWithStyle:(LGShowImageType)style {
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:style];
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = 3;   // 最多能选9张图片
    pickerVc.delegate = self;
    //    pickerVc.nightMode = YES;//夜间模式
    [pickerVc showPickerVc:self];
}
/**
 *  初始化自定义相机（单拍）
 */
- (void)presentCameraSingle {
    ZLCameraViewController *cameraVC = [[ZLCameraViewController alloc] init];
    // 拍照最多个数
    cameraVC.maxCount = 1;
    // 单拍
    cameraVC.cameraType = ZLCameraSingle;
    cameraVC.callback = ^(NSArray *cameras){
        //在这里得到拍照结果
        //数组元素是ZLCamera对象
        //         @exemple
        ZLCamera *canamerPhoto = cameras[0];
        UIImage *image = canamerPhoto.photoImage;
        [self calulateImageFileSize:canamerPhoto.photoImage];
         self.showImageView.image  = image;
    };
   
    [cameraVC showPickerVc:self];
}
- (void)calulateImageFileSize:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data = UIImageJPEGRepresentation(image, 1.0);//需要改成0.5才接近原图片大小，原因请看下文
    }
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}
#pragma mark - LGPhotoPickerViewControllerDelegate

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets isOriginal:(BOOL)original{
    
    //    assets的元素是LGPhotoAssets对象，获取image方法如下:
    
    [self.imageArr removeAllObjects];
       
       for (LGPhotoAssets *photo in assets) {
           //        缩略图
           //        [thumbImageArray addObject:photo.thumbImage];
           //        原图
           //        [originImage addObject:photo.originImage];
           //        全屏图
           //        [fullResolutionImage addObject:fullResolutionImage];
           
               [self.imageArr addObject: photo.thumbImage];
           
       }
       self.showImageView.image  = self.imageArr[0];
}

@end
