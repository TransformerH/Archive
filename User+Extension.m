//
//  User+Extension.m
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "User+Extension.h"

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
    
}
//手机号验证 post
+(void) checkphoneWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
}
//获得xrsf Get方法
+(void) getXrsfWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSLog(@"getXrsfWithParameters");
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/",[AFNetManager getMainURL]];
    
    [[AFNetManager manager] GET:getFirstURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"getxrsf Success");
        
        NSLog(@"令牌获取成功%@",responseObject);
        //  successBlock(responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSString *message = [dic objectForKey:@"message"];
        NSLog(@"User+exten: %@", dic);
     //   userXrsf = [xrsf getXrsf];
        //xrsf = [[NSString alloc] init];
       //xrsf = message;
        [User setXrsf:message];
        NSLog(@"test message output%@",xrsf);
        //NSString *cookie = [[NSString alloc] initWithFormat:@"_xrsf=%@",message];
        //[[AFNetManager manager].requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
        //User *user1= [[User alloc]init];
        NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:@"15996198251",@"telephone",@"cxh1234567",@"password", nil];
        NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
        successBlock(postdic,YES);
    

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
        NSLog(@"获取令牌失败%@",error);
       afnErrorblock(error);
    }];
    
    
    
    
}
//登陆，存储我的信息，圈子id获取，人脉
+(void) loginWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
     NSString *getFirstURL = [NSString stringWithFormat:@"%@/login",[AFNetManager getMainURL]];

    
    [self getXrsfWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
        
         [[AFNetManager manager] POST:getFirstURL  parameters:dict progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
       NSLog(@"%@", dic);
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
                         }];
    } AFNErrorBlock:^(NSError *error) {
        
    }];
    
    
   
    
}


/* 我的 */

//我的页面圈子内容获取
+(void) CirlceIntroduceWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
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
