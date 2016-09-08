//
//  User+Extension.m
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "User+Extension.h"
#import "AFNetManager.h"

static User *user;

@implementation User (Extension)

+ (User*)getUser{
    static dispatch_once_t dec;
    
    dispatch_once(&dec, ^{
        user = [[User alloc] init];
        //   xrsf = [[NSString alloc] init];
    });
    
    return user;
}

//注册 post
+(void) registerWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSString *registerURL = [[NSString alloc] initWithFormat:@"%@/register",[AFNetManager getMainURL]];
    NSDictionary *sendDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[self dictionaryToJson:parm],@"info_json", nil];
    
    [[AFNetManager manager]POST:registerURL parameters:sendDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"注册成功 %@",dic);
        
        successBlock(nil,YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"注册失败 %@",error);
        afnErrorblock(error);
        
    }];
    
    
}
//手机号验证 post
+(void) checkphoneWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
    [self getXrsfWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
        
        NSString *checkPhoneURL = [[NSString alloc] initWithFormat:@"%@/checkphone",[AFNetManager getMainURL]];
        
        NSDictionary *registerFirstDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[parm valueForKey:@"telephone"],@"telephone", nil];
        
        [[AFNetManager manager]POST:checkPhoneURL parameters:registerFirstDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSLog(@"检测手机号成功%@",dic);
            
            NSString *codeString = [[NSString alloc] initWithFormat:@"%@",[dic valueForKey:@"code"]];
            NSString *successMsg = [[NSString alloc] initWithFormat:@"%d",3002];
            NSString *error1 = [[NSString alloc] initWithFormat:@"%d",3001];
            NSString *error2 = [[NSString alloc] initWithFormat:@"%d",3003];
            
            if([codeString isEqualToString:successMsg]){
                NSLog(@"检测手机号成功%@",dic);
                //检测手机号成功，执行successBlock
                successBlock(nil,YES);
            }
            else if([codeString isEqualToString:error1]){
                //手机号码验证失败
                NSLog(@"手机号码已经注册");
            }else{
                NSLog(@"手机号输入格式错误");
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"检测手机号失败%@",error);
            afnErrorblock(error);
        }];
        
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"令牌获取失败：%@",error);
    }];
    
}

//获得xrsf Get方法
+(void) getXrsfWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSLog(@"getXrsfWithParameters");
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/",[AFNetManager getMainURL]];
    
    [[AFNetManager manager] GET:getFirstURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"令牌获取成功%@",dic);
        
        NSString *message = [dic objectForKey:@"message"];
        [User setXrsf:message];
        //        NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:@"15896193612",@"telephone",@"cxh1234567",@"password", nil];
        //        NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",xrsf,@"_xsrf", nil];
        successBlock(nil,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"获取令牌失败%@",error);
        afnErrorblock(error);
    }];
}
//登陆，存储我的信息，圈子id获取，人脉
+(void) loginWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/login",[AFNetManager getMainURL]];
    
    
    [self getXrsfWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
        
        NSString *userLogin = [self dictionaryToJson:parm];
        NSDictionary *loginDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",userLogin,@"info_json", nil];
        
        [[AFNetManager manager] POST:getFirstURL  parameters:loginDic progress:nil
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                                 NSLog(@"%@", dic);
                                 successBlock(dic,YES);
                                 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                 NSString *plistPath1= [paths objectAtIndex:0];
                                 
                                 NSLog(@"%@",plistPath1);
                                 //得到完整的路径名
                                 NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"User.plist"];
                                 NSDictionary *main = [dic objectForKey:@"Data"];
                                 NSDictionary *user = [main objectForKey:@"response"];
                                 
                                 NSFileManager *fm = [NSFileManager defaultManager];
                                 if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
                                     
                                     [user writeToFile:fileName atomically:YES];
                                     NSLog(@"文件写入完成");
                                 }
                                 
                             }
                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                 NSLog(@"失败");
                                 afnErrorblock(error);
                             }];
    } AFNErrorBlock:^(NSError *error) {
        
    }];
    
    
    
    
}


/* 我的 */

//我的页面圈子内容获取
+(void) CirlceIntroduceWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSString *myCircleURL = [[NSString alloc] initWithFormat:@"%@/get_my_filter_circle",[AFNetManager getMainURL]];
    
    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[parm valueForKey:@"my_admin_circle"],@"myfilter_circle", nil];
    [[AFNetManager manager] POST:myCircleURL parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"获取我的页面圈子内容成功 ：%@", dic);
        successBlock(nil,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取我的页面圈子内容失败 ：%@",error);
        afnErrorblock(error);
    }];
}
//收藏的名片获取
+(void) CardWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
}
//注销
+(void) logoutWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
}
//用户设置
+(void) userSettingWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
}


/*消息
 收到的评论*/
+(void) reciveCommentWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
}
//系统通知
+(void) systemMessageWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
}


//高级筛选
+(void) highSearchWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
