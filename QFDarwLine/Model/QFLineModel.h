//
//  QFLineModel.h
//  QFDarwLine
//
//  Created by qingfengiOS on 2019/1/29.
//  Copyright © 2019 qingfengiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QFLineModel : NSObject

/// x的值
@property (nonatomic, assign) CGFloat xValue;

/// y的值
@property (nonatomic, assign) CGFloat yValue;


- (instancetype)initWithX:(CGFloat)x y:(CGFloat)y;

@end

NS_ASSUME_NONNULL_END
