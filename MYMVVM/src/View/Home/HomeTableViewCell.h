//
//  HomeTableViewCell.h
//  MYMVVM
//
//  Created by 陈宝祥 on 2020/1/3.
//  Copyright © 2020 陈宝祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
@property(nonatomic,strong)HomeModel *homeModel;
@end

NS_ASSUME_NONNULL_END
