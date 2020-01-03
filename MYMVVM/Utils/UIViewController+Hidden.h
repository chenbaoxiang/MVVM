//
//  UIViewController+Hidden.h
//  Client
//
//  Created by loveRain on 2019/5/10.
//  Copyright © 2019年 loveRain. All rights reserved.
//

//
//  UIViewController+Hidden.h
//  demo
//
//  Created by loveRain on 2017/5/11.
//  Copyright © 2017年 ... All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface UIViewController (Hidden)<UINavigationControllerDelegate>

-(void)showAlert:(NSString *)t withContext:(NSString *)context handleOK:(void(^)(void))handle;

@end

