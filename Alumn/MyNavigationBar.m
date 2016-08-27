//
//  MyNavigationBar.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/24.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "MyNavigationBar.h"

@implementation MyNavigationBar



- (void)awakeFromNib {
    [super awakeFromNib];
    // 初始化界面
    [self initAllView];
}

- (void)initAllView {
    self.backgroundColor = [UIColor greenColor];
    self.leftView.backgroundColor = [UIColor clearColor];
    self.centerView.backgroundColor = [UIColor clearColor];
    self.rightView.backgroundColor = [UIColor clearColor];
    // 默认右侧按钮隐藏
    self.rightView.hidden = YES;
}

#pragma mark - event response

- (IBAction)leftBtnClick:(UIButton *)sender {
    if (_leftBtnClickHandler) {
        _leftBtnClickHandler();
    }
}

- (IBAction)rightBtnClick:(UIButton *)sender {
    if (_rightBtnClickHandler) {
        _rightBtnClickHandler();
    }
}

@end