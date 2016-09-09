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
//    self.NameLabel.frame=CGRectMake(0, 106, 375, 34);
//    self.NameLabel.numberOfLines=0;
//    self.NameLabel.textAlignment=NSTextAlignmentCenter;
//    CGSize size = [self.circleName sizeWithFont:_NameLabel.font constrainedToSize:CGSizeMake(_NameLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    [self.NameLabel setFrame:CGRectMake(0, 106, 375, size.height)];
    NSLog(@"%@",self.circleName);
     self.NameLabel.text = self.circleName;
    self.reasonlabel.enabled = NO;
    self.introLabel.enabled =NO;
    self.reasaonTextView.delegate =self;
    self.introTextView.delegate =self;
    self.reasonlabel.text = @"在此处填写您创建该圈子的理由";
    self.introLabel.text =@"在此处填写您对该圈子的介绍";
    self.pickerView.delegate=self;
    self.pickerView.frame = CGRectMake(0, 667, 375, 140);
    self.pickerView.hidden = YES;
    
    
    
    
    
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
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
     return [_typeArray count];
    
}
//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 25.0f;
}
//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component==0) {//iOS6边框占10+10
        return  self.view.frame.size.width;
    } else if(component==1){
        return  self.view.frame.size.width;
    }
    return  self.view.frame.size.width;
}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
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
    self.typeLabel.text =[_typeArray objectAtIndex:row];
    
}

- (void)textViewDidChange:(UITextView *)textView {
//    if(self.reasaonTextView.text.length==0)
//    {
//        self.reasonlabel.text = @"在此处填写您创建该圈子的理由";
//    }else{
//        self.reasonlabel.text=@"";
//    }
//    if(self.introTextView.text.length==0)
//    {
//        self.introLabel.text =@"在此处填写您对该圈子的介绍";
//    }else
//    {
//        self.introLabel.text=@"";
//    }
    self.introLabel.hidden= self.introTextView.hasText;
    self.reasonlabel.hidden = self.reasaonTextView.hasText;
}

- (IBAction)inView:(id)sender {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    self.pickerView.frame = CGRectMake(0, 245, 320, 260);
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
-(void)animationFinished{
    NSLog(@"动画结束!");
}

- (void)ViewAnimation:(UIView*)view willHidden:(BOOL)hidden {
    
    [UIView animateWithDuration:2 animations:^{
        if (hidden) {
            view.frame = CGRectMake(0, 560, 375, 140);
        }
    } completion:^(BOOL finished) {
        [view setHidden:hidden];
    }];
}

- (IBAction)popViewture:(id)sender {
    
    [self ViewAnimation:self.pickerView willHidden:NO];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





@end
