//
//  FindCircleViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/27.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "FindCircleViewController.h"

@interface FindCircleViewController ()

@end

@implementation FindCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   [ self setButtonStyle:_EnterpriseButton ];
    [self setButtonStyle:_softwareButton];
    [self setButtonStyle:_InternshipButton];
    [self setButtonStyle:_ecoManButton];
    [self setButtonStyle:
     _lawButton];
    [self setButtonStyle:_electricButton];
    
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

-(void)clickEffect :(UIButton *) BUTTON image:(UIImageView *) myimage
{
 
//    if (flag) {
        [UIView animateWithDuration:0.8 animations:^{
            //myimage.transform = CGAffineTransformMakeRotation(M_PI);
            //_enterpriseImage.transform =CGAffineTransformMakeScale(-1.0, 1.0);
            myimage.transform = CGAffineTransformMakeScale(0.7,0.7);
            
//        } completion:^(BOOL finished) {
//            flag = NO;
//        }];
//    }
//    else {
//        [UIView animateWithDuration:0.5 animations:^{
//           myimage.transform = CGAffineTransformMakeRotation(0);
//        } completion:^(BOOL finished) {
//            flag = YES;
//        }];
        }];
}

-(void)setButtonStyle:(UIButton *)mybutton
{
    
    [mybutton.layer setBorderWidth:1];
    [mybutton.layer setBorderColor :[UIColor grayColor].CGColor] ;
}
- (IBAction)enterpriseClicked:(id)sender {
    flag =YES;
    
    [self clickEffect:self.EnterpriseButton image:self.enterpriseImage];
    NSLog(@"you click enterprise.");
    
    
}

- (IBAction)softwareClicked:(id)sender {
    flag =YES;
    [self clickEffect:self.softwareButton image:self.softwareImage];
    NSLog(@"you click soft");
}

- (IBAction)InternshipClicked:(id)sender {
    flag =YES;
   [self clickEffect:self.InternshipButton image:self.InternshipImage];
   NSLog(@"you click intership");

}
- (IBAction)lawButtonClicked:(id)sender {
    [self clickEffect:self.lawButton image:self.lawImage];
    NSLog(@"you click law");
    
}

- (IBAction)ecoManButtonClicked:(id)sender {
    [self clickEffect:self.ecoManButton image:self.ecoManImage];
    NSLog(@"you click eco");
}

- (IBAction)electricButtonClicked:(id)sender {
    
    [self clickEffect:self.ecoManButton image:self.electricImage];
    NSLog(@"you click electric");
}


@end
