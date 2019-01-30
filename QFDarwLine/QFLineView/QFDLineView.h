//
//  QFDLineView.h
//  QFDarwLine
//
//  Created by qingfengiOS on 2019/1/29.
//  Copyright © 2019 qingfengiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QFLineModel;
NS_ASSUME_NONNULL_BEGIN

@interface QFDLineView : UIView

// 数据源
@property (nonatomic, copy) NSArray <QFLineModel *>*dataArray;

- (instancetype)lineViewWithFrame:(CGRect)frame dataSource:(NSArray <QFLineModel *>*)dataArray;

- (void)startDraw;
@end

NS_ASSUME_NONNULL_END
