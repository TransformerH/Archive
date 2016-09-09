//
//  Circle+Extension.h
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "Circle.h"
#import "AFNetManager.h"
@interface Circle (Extension)
+(Circle*) getCircle;
//获得圈子主页列表
+(void) getMainPageCircleWithParameters:(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//获得圈子详情
+(void) circleDeatilsWithParameters :(NSDictionary *) parm;
//获得分类里的圈子列表 名字，简介，图片等
+(void) circleIndexWithParameters :(NSDictionary *) parm;
//获得圈子动态列表
+(void) circeDynamicListWithParameters:(NSDictionary *)parm page:(NSNumber *) pages SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//申请加入圈子
+(void) joinCircleWithParameters :(NSDictionary *) parm;
// 创建圈子
+(void) createCircleFirstWithParameters :(NSDictionary *) parm;
+(void) createCircleSecondWithParameters :(NSDictionary *) parm;
//获得某个类型的圈子列表
+(void) getTypetopicWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
+(void) uploadPicture:(UIImage *)image;

+(void) createCircleWithParamenters :(NSDictionary *) parm;

@end
