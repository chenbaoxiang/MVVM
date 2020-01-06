//
//  UserTableViewCell.h
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/6.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserTableViewCell : UITableViewCell
@property(nonatomic,strong)UserModel *userModel;
@end

NS_ASSUME_NONNULL_END
