//
//  MyAltview.h
//  MyAltview
//
//  Created by Dorangefly Liu on 16/8/31.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyAltviewdelete;


@protocol MyAltviewdelete <NSObject>
////默认必须实现
//-(void)showmessage;
//
////@required 必须实现
@optional///表示不必须实现
-(void)showmessage;
-(void)alertview:(id)altview clickbuttonIndex:(NSInteger)index;

@end

@interface MyAltview : UIView<MyAltviewdelete>
{
    //   id <Customalertdelete> _delegate;
    
    float altheight;
    
}
//初始化显示结果
-(void)CreatAlt:(UIImage*)backimg circleName:(NSString *) Name altTitle:(NSString *)Title  Content:(NSString *)content altButton:(NSArray *)altbtnArray altbtnTcolor:(UIColor *)color altselectbtnTcolor:(UIColor *)selectcolor;
//显示
-(void)show;
//隐藏
-(void)hide;
@property(nonatomic)  float  altwidth;
@property(nonatomic,retain)  UIView *view;
@property(nonatomic,assign)id<MyAltviewdelete> deleta;
@property(nonatomic) NSString *str;
@property(nonatomic) NSString *name;
@end
