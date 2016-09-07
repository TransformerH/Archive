//
//  DemoVC5Model.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/28.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface DemoVC5Model : NSObject

@property (nonatomic, copy) NSArray *icon_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSDictionary *image_urls;
@property (nonatomic, copy) NSString *create_time;

+(id)modelWithDict:(NSDictionary *)dict;

@end
