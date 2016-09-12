//
//  RegisterFiveVC.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 8/29/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "RegisterFiveVC.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "RegisterViewModel.h"
#import "Circle.h"
#import "Circle+Extension.h"

@interface RegisterFiveVC()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pickImgView;
@property (weak, nonatomic) IBOutlet UIButton *pickPhoto;

//--------------------------  获取头像
@property (nonatomic,strong) UIActionSheet *actionSheet;

@property (strong,nonatomic) RegisterViewModel *registerVM;

@end

@implementation  RegisterFiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.registerVM = [RegisterViewModel getRegisterVM];
    
    //---------------------------------------------   设置navigationBar透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    //----------------------------------------------  设置navigationBar透明
    
    
    // self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    self.finishBtn.layer.masksToBounds = YES;
    self.finishBtn.layer.cornerRadius = 6.0;
    
    _pickImgView.image = [self OriginImage:[UIImage imageNamed:@"register_picking"] scaleToSize:_pickImgView.bounds.size];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    
    [self.pickPhoto setImage:[UIImage imageNamed:@"takePhoto"] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self bindVM];
}

-(void)bindVM{
    self.registerVM.user.icon_url = @"icon_url here";
    RAC(self.finishBtn,enabled) = self.registerVM.registerFiveEnableSiganl;
    
    [[self.finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.registerVM.registerCommand execute:nil];
    }];
    
    [self.registerVM.registerCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        if([result isEqualToString:@"success"]){
            NSLog(@"register finish");
            NSDictionary *userDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.registerVM.user.password,@"password",self.registerVM.user.telephone,@"telephone", nil];
            
            [User loginWithParameters:userDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
                
                NSLog(@"注册后自动登录成功");
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *VC = [sb instantiateViewControllerWithIdentifier:@"FiveTab"];
                [self.navigationController pushViewController:VC animated:YES];
                
            } AFNErrorBlock:^(NSError *error) {
                
                NSLog(@"注册后自动登录失败");
                
            }];
            
        }else{
            NSLog(@"register failed");
        }
    }];
}

-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (void)callActionSheetFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 2) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.pickImgView.image = image;
    self.pickImgView.layer.masksToBounds = YES;
    self.pickImgView.layer.cornerRadius = self.pickImgView.bounds.size.width / 2.0;
    
    self.registerVM.user.userHeadImg = image;
}
- (IBAction)selectPhotoClicked:(id)sender {
    
    [self callActionSheetFunc];
}





@end
