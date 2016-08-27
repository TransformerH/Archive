//
//  MyNavigationBar.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/24.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NavBtnClickBlock)();

@interface MyNavigationBar : UIView

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *centerView;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *centerLbl;

@property (nonatomic, copy) NavBtnClickBlock leftBtnClickHandler;
@property (nonatomic, copy) NavBtnClickBlock rightBtnClickHandler;
@end
