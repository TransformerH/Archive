//
//  DemoVC5Model.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/28.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#import "DemoVC5Model.h"

@implementation DemoVC5Model
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        self.content = [dict objectForKey:@"content"];
        self.create_time = [dict objectForKey:@"create_time"];
        //self.image_urls = [dict objectForKey:@"image_urls" ];
        NSDictionary *creator = [dict objectForKey:@"creator"];
        //self.icon_url = [creator objectForKey:@"icon_url"];
        self.name = [creator objectForKey:@"name"];
        }
    return self;
}

+(id)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
