//
//  Circle+Extension.m
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "Circle+Extension.h"
#import "AFNetManager.h"
#import "User.h"

@implementation Circle (Extension)

static Circle *circle;
+ (Circle*)getCircle{
    static dispatch_once_t dec;
    
    dispatch_once(&dec, ^{
       circle  = [[Circle alloc] init];
        //   xrsf = [[NSString alloc] init];
    });
    
    return circle;
}
+(void) getMainPageCircleWithParameters :(NSDictionary *) parm
{
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/get_my_circle",[AFNetManager getMainURL]];
    NSLog(@"User+exten: %@", [User getXrsf]);
    extern NSString *xrsf;
    NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [User getXrsf],@"_xsrf", nil];
    NSLog(@"User+exten: %@", postdic);
    [[AFNetManager manager] POST:getFirstURL parameters:postdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"User+exten: %@", dic);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        
        NSLog(@"%@",plistPath1);
        //得到完整的路径名
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"MainPageCircle.plist"];
        NSDictionary *main = [dic objectForKey:@"Data"];
        NSDictionary *result = [main objectForKey:@"response"];
        NSDictionary *mainCilrcle = [result objectForKey:@"results"];
            NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
            
            [mainCilrcle writeToFile:fileName atomically:YES];
            NSLog(@"文件写入完成");  
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
    }];
    
 
}
//获得分类里的圈子列表 名字，简介，图片等
+(void) circleIndexWithParameters :(NSDictionary *) parm
{
    
}
//申请加入圈子
+(void) joinCircleWithParameters :(NSDictionary *) parm
{
    
}
// 创建圈子
+(void) createCircleFirstWithParameters :(NSDictionary *) parm
{
    
}
+(void) createCircleSecondWithParameters :(NSDictionary *) parm
{
    
}

//获得某个类型的圈子列表
+(void) getTypetopicWithParameters :(NSDictionary *) parm
{
      NSString *getFirstURL = [NSString stringWithFormat:@"%@/gettypetopic",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"User+exten: %@", dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
    }];
    

 
}

//获得圈子详情
+(void) circleDeatilsWithParameters :(NSDictionary *) parm
{
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/detail_circle",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"circle deatil: %@", dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
    }];

    
}

//获得圈子动态列表
+(void) circeDynamicListWithParameters:(NSDictionary *)parm page:(NSNumber *) pages;
{
    //得到完整的路径名
//    BOOL flag =false;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *plistName =[[NSString alloc] initWithFormat:@"DynamicList%@.plist",pages];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:plistName];
   
    NSFileManager *fm = [NSFileManager defaultManager];

    NSString *getFirstURL = [NSString stringWithFormat:@"%@/circle_feed",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"circle deatil: %@", responseObject);
        //NSLog(@"circle deatil: %@", dic);
        
        
        NSLog(@"%@",plistPath1);
        NSDictionary *main = [dic objectForKey:@"Data"];
        NSDictionary *result = [main objectForKey:@"response"];
        NSDictionary *list = [result objectForKey:@"results"];

        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
            [list writeToFile:fileName atomically:YES];
                        NSLog(@"文件写入完成");
           
        }
        
       


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
    }];
    // flag=true;
//}
    
}



+(void) uploadPicture:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.001);
    NSString *_encodedImageStr = [imageData base64Encoding];
    
    NSLog(@"%@",_encodedImageStr);
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/uploadimg",[AFNetManager getMainURL]];

//[[AFNetManager manager]POST:getFirstURL  parameters:_encodedImageStr constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    // 上传文件
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat            = @"yyyyMMddHHmmss";
//    NSString *str                         = [formatter stringFromDate:[NSDate date]];
//    NSString *fileName               = [NSString stringWithFormat:@"%@.jpg", str];
//    
//    [formData appendPartWithFileData:imageData name:@"photos" fileName:fileName mimeType:@"image/png"];
//    
//} progress:^(NSProgress * _Nonnull uploadProgress) {
//    
//} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//    NSLog(@"上传成功");
//} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    NSLog(@"失败");
//}];
}

@end
