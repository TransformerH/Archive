//
//  createCircleStep2.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/8.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "createCircleStep2.h"

@interface createCircleStep2 ()

@end

@implementation createCircleStep2

- (void)viewDidLoad {
    [super viewDidLoad];
    _typeArray = [NSArray arrayWithObjects:@"创业圈",@"软件圈",@"经管圈",@"实习圈",@"法律圈",@"电气圈",nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark pickerview function

//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return  5;
    } else if(component==1){
        
        return  [_typeArray count];
    }
    return [_typeArray count];
}
//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 20.0f;
}
//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component==0) {//iOS6边框占10+10
        return  self.view.frame.size.width/3;
    } else if(component==1){
        return  self.view.frame.size.width/3;
    }
    return  self.view.frame.size.width/3;
}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, 20)];
    text.textAlignment = NSTextAlignmentCenter;
    text.text = [_typeArray objectAtIndex:row];
    [view addSubview:text];
    
    return view;
}
//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = [_typeArray objectAtIndex:row];
    return str;
}
//显示的标题字体、颜色等属性
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = [_typeArray objectAtIndex:row];
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
    
    return AttributedString;
}//NS_AVAILABLE_IOS(6_0);

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"HANG%@",[_typeArray objectAtIndex:row]);
    
}




@end
