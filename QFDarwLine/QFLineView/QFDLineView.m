//
//  QFDLineView.m
//  QFDarwLine
//
//  Created by qingfengiOS on 2019/1/29.
//  Copyright © 2019 qingfengiOS. All rights reserved.
//

#import "QFDLineView.h"

#import "QFLineModel.h"

static CGRect viewRect;//View的大小
static NSInteger xCount;//x数目
static NSInteger yCount;//y数目

static CGFloat chartWidth;//表宽度
static CGFloat chartHeight;//表高度

static CGFloat perX;//横间距
static CGFloat perY;//纵间距

static CGFloat maxY;// 最大的y值

static NSInteger kMargin = 30;

@interface QFDLineView ()

@end

@implementation QFDLineView

- (instancetype)lineViewWithFrame:(CGRect)frame dataSource:(NSArray <QFLineModel *>*)dataArray {
    if (self == [super init]) {
        self.dataArray = dataArray;
        [self initDataSource:frame];
        [self initAppreaence:frame];
    }
    return self;
}

#pragma mark - InitAppreaence
- (void)initAppreaence:(CGRect)frame {
    self.backgroundColor = [UIColor greenColor];
    self.frame = frame;
    
}

#pragma mark - InitDataSource
- (void)initDataSource:(CGRect)frame {
    viewRect = frame;
    
    xCount = self.dataArray.count;
    yCount = self.dataArray.count >= 5 ? 5 : self.dataArray.count;
    
    perX = (CGRectGetWidth(viewRect) - kMargin) / xCount;
    perY = (CGRectGetHeight(viewRect) - kMargin) / yCount;
    
    maxY = CGFLOAT_MIN;
    for (NSInteger i = 0; i < xCount; i++) {
        if (self.dataArray[i].yValue > maxY) {
            maxY = self.dataArray[i].yValue;
        }
    }
    
    chartWidth = CGRectGetWidth(viewRect) - kMargin * 2;
    chartHeight = CGRectGetHeight(viewRect) - kMargin * 2;
    
}

#pragma mark - Public
- (void)startDraw {
    [self drawXYLine];
    [self drawScaleLabel];
    [self drawPoint];
    [self drawLine];
    [self drawReseau];
}

#pragma mark - CustomDelegates

/**
 画X、Y轴
 */
- (void)drawXYLine {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    //左上角
    [bezierPath moveToPoint:CGPointMake(kMargin, kMargin)];
    
    //原点
    [bezierPath addLineToPoint:CGPointMake(kMargin, CGRectGetHeight(viewRect) - kMargin)];
    
    //右顶端
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(viewRect) - kMargin, CGRectGetHeight(viewRect) - kMargin)];
 
    //纵向箭头
    [bezierPath moveToPoint:CGPointMake(kMargin - 3, kMargin +  4)];
    [bezierPath addLineToPoint:CGPointMake(kMargin , kMargin)];
    [bezierPath addLineToPoint:CGPointMake(kMargin + 3, kMargin + 4)];
    
    //横向箭头
    [bezierPath moveToPoint:CGPointMake(CGRectGetWidth(viewRect) - kMargin - 4, CGRectGetHeight(viewRect) - kMargin  - 3)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(viewRect) - kMargin, CGRectGetHeight(viewRect) - kMargin)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(viewRect) - kMargin - 4, CGRectGetHeight(viewRect) - kMargin  + 3)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 2;
    [self.layer addSublayer:layer];
}


/**
 画X、Y轴的刻度
 */
- (void)drawScaleLabel {
    
    //Y轴刻度
    for (NSInteger i = 0; i < yCount; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, kMargin + perY * i - perY / 2, kMargin - 5, perY)];
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"%d", (int)(maxY / yCount * (yCount - i))];
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
    }
    
    //X轴刻度
    for (NSInteger i = 1; i <= self.dataArray.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(perX * i - perX / 2, CGRectGetHeight(viewRect) - kMargin, perX, kMargin)];
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"%.0f", self.dataArray[i - 1].xValue];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}


/**
 画点
 */
- (void)drawPoint {
    for (int i = 0; i < self.dataArray.count; i++) {
        
        CGPoint point = CGPointMake(perX * (i + 1),kMargin + (1 - self.dataArray[i].yValue / maxY) * chartHeight);
        
        
        CAShapeLayer *layer = [CAShapeLayer layer];
//        layer.frame = CGRectMake(point.x - 2.5, point.y - 2.5, 5, 5);//矩形点
        
        UIBezierPath *beizierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x - 2.5, point.y - 2.5, 5, 5) cornerRadius:2.5];
        layer.path = beizierPath.CGPath;//圆点
        
        layer.strokeColor = [UIColor redColor].CGColor;
        layer.fillColor = [UIColor redColor].CGColor;
        layer.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:layer];
    }
}


/**
 画折线
 */
- (void)drawLine {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(perX, kMargin + (1 - [self.dataArray firstObject].yValue / maxY) * chartHeight)];
    
    for (int i = 1; i < self.dataArray.count; i++) {
        [bezierPath addLineToPoint:CGPointMake(perX * (i + 1), kMargin + (1 - self.dataArray[i].yValue / maxY) * chartHeight)];
    }
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = bezierPath.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:layer];
}


/**
 画网格
 */
- (void)drawReseau {
    
    UIBezierPath *beziPatn = [UIBezierPath bezierPath];
    
    //横线
    for (int i = 0; i < yCount; i++) {
        [beziPatn moveToPoint:CGPointMake(kMargin, kMargin + perY * i)];
        [beziPatn addLineToPoint:CGPointMake(kMargin + chartWidth, kMargin + perY * i)];
    }
    
    //竖线
    for (int i = 0; i < xCount; i++) {
        [beziPatn moveToPoint:CGPointMake(kMargin + perX * i, kMargin)];
        [beziPatn addLineToPoint:CGPointMake(kMargin + perX * i, kMargin + chartHeight)];
    }
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = beziPatn.CGPath;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 0.5;
    [self.layer addSublayer:layer];
}

@end
