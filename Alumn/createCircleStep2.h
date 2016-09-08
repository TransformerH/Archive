//
//  createCircleStep2.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/8.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface createCircleStep2 : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSArray *_typeArray;
}

@property (strong, nonatomic) UIPickerView *pickerView;


@end
