//
//  FindCircleViewController.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/27.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindCircleViewController : UIViewController
{
     BOOL flag; 
}
@property (weak, nonatomic) IBOutlet UIButton *EnterpriseButton;
@property (weak, nonatomic) IBOutlet UIImageView *enterpriseImage;
@property (weak, nonatomic) IBOutlet UIImageView *softwareImage;
@property (weak, nonatomic) IBOutlet UIButton *softwareButton;
@property (weak, nonatomic) IBOutlet UIButton *InternshipButton;
@property (weak, nonatomic) IBOutlet UIImageView *InternshipImage;
@property (weak, nonatomic) IBOutlet UIImageView *lawImage;
@property (weak, nonatomic) IBOutlet UIButton *lawButton;
@property (weak, nonatomic) IBOutlet UIImageView *ecoManImage;
@property (weak, nonatomic) IBOutlet UIButton *ecoManButton;
@property (weak, nonatomic) IBOutlet UIImageView *electricImage;
@property (weak, nonatomic) IBOutlet UIButton *electricButton;

-(void)clickEffect :(UIButton *) BUTTON image:(UIImageView *) myimage;

@end
