//
//  QFLineModel.m
//  QFDarwLine
//
//  Created by qingfengiOS on 2019/1/29.
//  Copyright © 2019 qingfengiOS. All rights reserved.
//

#import "QFLineModel.h"

@implementation QFLineModel

- (instancetype)initWithX:(CGFloat)x y:(CGFloat)y {
    if (self = [super init]) {
        self.xValue = x;
        self.yValue = y;
    }
    return self;
}

@end
