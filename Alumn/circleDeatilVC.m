//
//  circleDeatilVC.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/26.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "circleDeatilVC.h"
#import "RNTableViewController.h"
#import "RNContainerController.h"
#import "searchController.h"
#import "searchController.h"
#import "searchViewController.h"
//#import "WeiXinFriendsCircleVC .h"
@implementation circleDeatilVC


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.NavBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.NavBar.layer.masksToBounds = YES;
    [self.NavBar setBackgroundColor:[UIColor clearColor]];
    [self.cicrleName setText:@"圈子名称"];
    [self.cicrleName endEditing:true];
    [self.numbers setText:@"成员 ％ld"];
   [self.view bringSubviewToFront:_setButton];
    [self.ciecleDeatilMask2 setHidden:true];
    [self.setButton1 setHidden:true];
    [self.setButton2 setHidden:true];
    [self.setButton3 setHidden:true];
    [self.ExitButton setHidden:true];
    
    
    
    
    

    
}


- (IBAction)setButtonCilcked:(id)sender {
    [self.setButton setHidden:true];
    [self.searchButton setHidden:true];
    [self.settingButton setHidden:true];
    //self.setButton.hidden =YES;
    [self.ciecleDeatilMask2 setHidden:false];
    [self.setButton1 setHidden:false];
    [self.setButton2 setHidden:false];
    [self.setButton3 setHidden:false];
    [self.ExitButton setHidden:false];
}
- (IBAction)exitButtonClicked:(id)sender {
    [self.ciecleDeatilMask2 setHidden:true];
    //[self.setButton1 setHidden:true];
    self.setButton1.hidden =YES;
    [self.setButton2 setHidden:true];
    [self.setButton3 setHidden:true];
    [self.ExitButton setHidden:true];
    [self.setButton setHidden:false];
    [self.searchButton setHidden:false];
    [self.settingButton setHidden:false];

    
    
}
- (IBAction)back:(id)sender {
    // 返回之前storyboard定义界面
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)searchButtonClicked:(id)sender {
    searchViewController *ContmetViewController =[[searchViewController alloc] init];
  [self.view addSubview:[ContmetViewController init].view];
   

    
    //UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[[searchController alloc] init]];

    //[self.view addSubview:[nav init].view];
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    

    
}





@end
