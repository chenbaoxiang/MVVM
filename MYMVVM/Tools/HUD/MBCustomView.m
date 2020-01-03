//
//  SNMBCustomView.m
//  TheNewAnime
//
//  Created by wangsen on 2016/11/9.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "MBCustomView.h"
@interface MBCustomView ()

@end
@implementation MBCustomView

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        _contentSize = CGSizeMake(100.f, 100.f);
    }
    return self;
}
- (CGSize)intrinsicContentSize {
    return _contentSize;
}

@end
