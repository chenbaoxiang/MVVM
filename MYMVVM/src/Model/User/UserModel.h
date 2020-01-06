//
//  UserModel.h
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/2.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *headerImage;
@property (nonatomic, copy) NSString *time;


@property (nonatomic, assign) long sub_number;
@end

NS_ASSUME_NONNULL_END
