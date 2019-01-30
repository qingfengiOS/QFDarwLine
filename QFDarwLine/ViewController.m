//
//  ViewController.m
//  QFDarwLine
//
//  Created by qingfengiOS on 2019/1/29.
//  Copyright © 2019 qingfengiOS. All rights reserved.
//

#import "ViewController.h"
#import "QFDLineView.h"
#import "QFLineModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QFLineModel *m = [[QFLineModel alloc]initWithX:0 y:2];
    QFLineModel *m2 = [[QFLineModel alloc]initWithX:1 y:8];
    QFLineModel *m3 = [[QFLineModel alloc]initWithX:2 y:4];
    QFLineModel *m4 = [[QFLineModel alloc]initWithX:3 y:15];
    QFLineModel *m5 = [[QFLineModel alloc]initWithX:4 y:10];
    QFLineModel *m6 = [[QFLineModel alloc]initWithX:5 y:14];
    QFLineModel *m7 = [[QFLineModel alloc]initWithX:6 y:4];
    QFLineModel *m8 = [[QFLineModel alloc]initWithX:7 y:12];
    QFLineModel *m9 = [[QFLineModel alloc]initWithX:8 y:14];
    QFLineModel *m10 = [[QFLineModel alloc]initWithX:9 y:15];

    QFDLineView *view = [[QFDLineView alloc]lineViewWithFrame: CGRectMake(20, 150, 350, 240) dataSource:@[m,m2,m3,m4,m5,m6,m7,m8,m9,m10]];
    [view startDraw];
    
    [self.view addSubview:view];
}


@end
